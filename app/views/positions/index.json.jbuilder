json.array!(@positions) do |position|
  json.extract! position, :id, :title, :organization, :connection_id
  json.url position_url(position, format: :json)
end
