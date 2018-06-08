json.extract! notification, :id, :id_user, :id_friend, :id_post, :visto, :created_at, :updated_at
json.url notification_url(notification, format: :json)
