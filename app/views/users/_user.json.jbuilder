json.extract! user, :id, :carnet, :nombre, :email, :password, :auth_token, :foto, :created_at, :updated_at
json.url user_url(user, format: :json)
