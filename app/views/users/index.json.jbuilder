json.array!(@users_search) do |user|
  json.name        user.name
  json.email       user.email
end
