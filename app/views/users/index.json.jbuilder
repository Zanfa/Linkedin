json.array!(@users) do |user|
  json.extract! user, :id, :linkedin_id, :linkedin_token
  json.url user_url(user, format: :json)
end
