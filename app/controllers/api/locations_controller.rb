module Api
  class LocationsController < ApplicationController
    protect_from_forgery with: :null_session

    def get_friends_locations
      user = User.where(id: params[:id]).first
      if(user)
        locations = []
        amigos = Amigo.where(id_user1: user.id)
        amigos.each do |amigo|
          location = Location.where(id_user: amigo.id_user).first
          if(location)
            locations.push(location)
          end
        end
        render json: { status: 'SUCCESS', message: 'Ubicaciones obtenidas', locations: locations}, status: :ok
      else
        render json: { status: 'INVALID', message: 'Error al obtener ubicaciones'}, status: :unauthorized
      end
    end

    def create
      user = User.where(id: params[:id]).first
      if(user)
        Location.where(id_user: user.id).destroy_all

        loc = Location.new(id_user: user.id, latitud: params[:latitud], longitud: params[:longitud])
        if(loc.save)
          render json: { status: 'SUCCESS', message: 'Ubicaciones creada' }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al crear ubicación'}, status: :unauthorized
        end
      else
        render json: { status: 'INVALID', message: 'Error al crear ubicación'}, status: :unauthorized
      end
    end
  end
end