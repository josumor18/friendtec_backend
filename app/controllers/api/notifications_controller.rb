module Api
  class NotificationsController < ApplicationController
    protect_from_forgery with: :null_session

    def get
      user = User.where(id: params[:id]).first

      if(user)
        notifi = []
        notif = Notification.where(id_user: user.id)
        notif.order("created_at DESC")
        render json: { status: 'SUCCESS', message: 'Notificaciones obtenidas', notificaciones: notif}, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al obtener notificaciones'}, status: :unauthorized
      end
    end
  end
end