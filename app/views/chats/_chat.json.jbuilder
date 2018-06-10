json.extract! chat, :id, :id_user, :id_friend, :last_message, :visto, :created_at, :updated_at
json.url chat_url(chat, format: :json)
