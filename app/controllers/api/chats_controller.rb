module Api
  class ChatsController < ApplicationController
    protect_from_forgery with: :null_session

    def get
      user = User.where(id: params[:id]).first

      if(user)
        chats = Chat.where(id_user: user.id)

        chats.order("created_at DESC")
        render json: { status: 'SUCCESS', message: 'Chats obtenidos', chats: chats}, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al obtener chats'}, status: :unauthorized
      end
    end

    def set_true
      chat = Chat.where(id: params[:id_chat]).first

      if(chat)
        chat.visto = true
        chat.save
        render json: { status: 'SUCCESS', message: 'Chats modificado'}, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al modificar estado del chat'}, status: :unauthorized
      end
    end

    ######################## MESSAGES MANAGEMENT ########################
    def get_chat_messages
      chat = Chat.where(id: params[:id_chat]).first

      if(chat)
        chat.visto = true
        chat.save

        mensajes = Message.where(id_chat: chat.id)
        mensajes.order("created_at ASC")
        render json: { status: 'SUCCESS', message: 'Chats modificado', mensajes: mensajes}, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al modificar estado del chat'}, status: :unauthorized
      end
    end

    def send_message
      user = User.where(id: params[:id]).first
      id_chat = params[:id_chat]
      id_friend = params[:id_friend]
      message = params[:message]
      if(user)
        if (id_chat == '0') #Chat nuevo
          chat1 = Chat.new(id_user: user.id, id_friend: id_friend, last_message: message, visto: true)
          chat2 = Chat.new(id_user: id_friend, id_friend: user.id, last_message: message, visto: false)
          chat1.save
          chat2.save
          men1 = Message.new(id_chat: chat1.id, message: message, enviado: true)
          men2 = Message.new(id_chat: chat2.id, message: message, enviado: false)
          men1.save
          men2.save
        else
          chat1 = Chat.where(id: id_chat).first
          chat2 = Chat.where(id_user: chat1.id_friend).where(id_friend: chat1.id_user).first
          chat1.last_message = message
          chat2.last_message = message
          chat2.visto = false
          chat1.save
          chat2.save
          men1 = Message.new(id_chat: id_chat, message: message, enviado: true)
          men2 = Message.new(id_chat: chat2.id, message: message, enviado: false)
          men1.save
          men2.save
        end
        render json: { status: 'SUCCESS', message: 'Mensaje enviado' }, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al enviar mensaje'}, status: :unauthorized
      end
    end
  end
end