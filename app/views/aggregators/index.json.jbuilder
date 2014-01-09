json.array!(@aggregators) do |aggregator|
  json.extract! aggregator, :id, :name, :invite_key, :owner_id
  json.url aggregator_url(aggregator, format: :json)
end
