class PublishNetworkCrawl
  include SuckerPunch::Job
  workers 10

  def perform(id)

    conn = Bunny.new(ENV['RABBITMQ_BIGWIG_TX_URL'])
    conn.start

    ch   = conn.create_channel
    q    = ch.queue('network_crawl')

    q.publish({id: id}.to_json, persistent: true)
    conn.close

  end
end