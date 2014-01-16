class NetworkWorker
  def initialize

    @conn = Bunny.new(ENV['RABBITMQ_BIGWIG_URL'])
    @conn.start

    @ch = @conn.create_channel
    @queue = @ch.queue('network_crawl')
    @profile_queue = @ch.queue('profile_crawl')
    @ch.prefetch(1)
    listen

  end

  def listen
    puts 'Started NetworkWorker...'

    begin
      @queue.subscribe(ack: true, block: true) do |delivery_info, properties, body|
        msg = JSON.parse(body, {symbolize_names: true})
        puts 'Received a message'

        process(msg)

        puts 'Finished processing'

        @ch.ack(delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      @conn.close
    end
  end

  def process(msg)
    ActiveRecord::Base.connection_pool.with_connection do

      user = User.find(msg[:id])

      if user.should_crawl?
        user.last_crawled = Time.now
        user.save

        client = LinkedIn::Client.new(ENV['LINKEDIN_API_KEY'], ENV['LINKEDIN_SECRET_KEY'])
        client.authorize_from_access(user.linkedin_token, user.linkedin_secret)

        client.connections.all.each do |connection|

          next if connection.id == 'private'

          saved_connection = Connection.where(linkedin_id: connection.id).first_or_initialize
          saved_connection.tap do |c|
            c.first_name = connection.first_name
            c.last_name = connection.last_name
            c.headline = connection.headline

            c.users.push user unless c.users.include? user
          end
          saved_connection.save

          @profile_queue.publish({id: saved_connection.id}.to_json, persistent: true)
        end
      end

    end
  end

end