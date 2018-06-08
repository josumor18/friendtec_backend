module Api
  class NotificationsController < ApplicationController
    protect_from_forgery with: :null_session

    def get
      user = User.where(id: params[:id]).first

      if(user)
        notif = Notification.where(id_user: user.id)
        notif.order("created_at DESC")
        render json: { status: 'SUCCESS', message: 'Notificaciones obtenidas', notificaciones: notif}, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al obtener notificaciones'}, status: :unauthorized
      end
    end

    def set_false
      user = User.where(id: params[:id]).first

      if(user)
        notificaciones = Notification.where(id_user: user.id)
        notificaciones.each do |notif|
          notif.visto = true
          notif.save
        end

      #  render json: { status: 'SUCCESS', message: 'Notificaciones modificadas'}, status: :ok
      #else
      #  render json: { status: 'INVALID', message: 'Error al modificar notificaciones'}, status: :unauthorized
      end
    end
  end
end