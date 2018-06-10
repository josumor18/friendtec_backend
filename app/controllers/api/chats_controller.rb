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
      chat = User.where(id: params[:id_chat]).first

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
  end
end