json.array!(@users) do |user|
  json.extract! user, :id, :instructor_id, :username, :password_digest, :role, :active
  json.url user_url(user, format: :json)
end
