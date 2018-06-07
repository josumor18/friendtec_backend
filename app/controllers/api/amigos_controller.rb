module Api
  class AmigosController < ApplicationController
    protect_from_forgery with: :null_session

    def get_amigos
      user = User.where(id: params[:id]).first
      if(user)
        amigos = Amigo.where(id_user1: user.id)

        lista_amigos = []
        amigos.each do |amigo|
          usuario = User.where(id: amigo.id_user2).first
          if(usuario)
            lista_amigos.push(usuario)
          end
        end
        render json: { status: 'SUCCESS', message: 'Amigos obtenidos', amigos: lista_amigos}, status: :ok

      else
        render json: { status: 'INVALID', message: 'Error al obtener los amigos'}, status: :unauthorized
      end
    end

  end
end