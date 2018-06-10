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
      user = User.where(id: params[:id]).first

      if(user)
        chats = Chat.where(id_user: user.id)
        chats.each do |chat|
          chat.visto = true
          chat.save
        end

        render json: { status: 'SUCCESS', message: 'Notificaciones modificadas'}, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al modificar notificaciones'}, status: :unauthorized
      end
    end
  end
end