json.array!(@connections) do |connection|
  json.extract! connection, :id, :first_name, :last_name, :headline
  json.url connection_url(connection, format: :json)
end
