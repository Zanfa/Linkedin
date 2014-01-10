class ProfileWorker

  def initialize

    @conn = Bunny.new(ENV['RABBITMQ_BIGWIG_URL'])
    @conn.start

    @ch = @conn.create_channel
    @queue = @ch.queue('profile_crawl')
    @error_queue = @ch.queue('error_queue')
    @ch.prefetch(1)
    listen

  end

  def listen
    puts 'Started ProfileWorker...'

    begin
      @queue.subscribe(ack: true, block: true) do |delivery_info, properties, body|
        msg = JSON.parse(body, {symbolize_names: true})
        puts 'Received a message'

        begin

        process(msg)

        rescue Exception => e
          puts e
          msg[:error] = e
          @error_queue.publish(msg.to_json, persistent: true)
        end

        @ch.ack(delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      @conn.close
    end
  end

  def process(msg)
    scraper = ProfileScraper.new

    ActiveRecord::Base.connection_pool.with_connection do

      connection = Connection.find(msg[:id])
      scraped_positions = scraper.find(connection.first_name, connection.last_name, connection.headline)

      if scraped_positions
        connection.profile = scraped_positions
        connection.save
      end

      puts 'Finished processing'
    end
  end

end