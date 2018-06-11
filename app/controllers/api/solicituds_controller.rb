module Api
  class SolicitudsController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      user = User.where(id: params[:id]).first
      if(user.auth_token == params[:auth_token])
        solicitud = Solicitud.new(id_user1: params[:id], id_user2: params[:id_user2])
        if (solicitud.save)
          #---------- Cambiar authentication token ----------
          user.auth_token = nil
          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          user.auth_token = (0...20).map { o[rand(o.length)] }.join
          user.save
          #--------------------------------------------------
          render json: { status: 'SUCCESS', message: 'Solicitud creada', auth_token: user.auth_token }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al guardar solicitud'}, status: :unauthorized
        end
      else
        render json: { status: 'INVALID', message: 'Token invalido'}, status: :unauthorized
      end
    end

    def get
      user = User.where(id: params[:id]).first
      if(user)
        solicitudes = Solicitud.where(id_user1: user.id)

        lista_solicitudes = []
        solicitudes.each do |solicitud|
          usuario = User.where(id: solicitud.id_user2).first
          if(usuario)
            lista_solicitudes.push(usuario)
          end
        end
        render json: { status: 'SUCCESS', message: 'Solicitudes obtenidas', solicitudes: lista_solicitudes}, status: :ok

      else
        render json: { status: 'INVALID', message: 'Error al obtener las solicitudes'}, status: :unauthorized
      end
    end

    def aceptar
      user = User.where(id: params[:id]).first
      if(user.auth_token == params[:auth_token])
        amigo1 = Amigo.new(id_user1: params[:id], id_user2: params[:id_user2])
        amigo2 = Amigo.new(id_user1: params[:id_user2], id_user2: params[:id])
        if (amigo1.save && amigo2.save)
          Solicitud.where(id_user2: user.id).where(id_user1: id_user2).destroy_all
          #---------- Cambiar authentication token ----------
          user.auth_token = nil
          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          user.auth_token = (0...20).map { o[rand(o.length)] }.join
          user.save
          #--------------------------------------------------
          render json: { status: 'SUCCESS', message: 'Solicitud aceptada', auth_token: user.auth_token }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al guardar solicitud aceptada'}, status: :unauthorized
        end
      else
        render json: { status: 'INVALID', message: 'Token invalido'}, status: :unauthorized
      end
    end

    def delete
      user = User.where(id: params[:id]).first
      if(user.auth_token == params[:auth_token])
        Solicitud.where(id_user2: user.id).where(id_user1: id_user2).destroy_all
        #---------- Cambiar authentication token ----------
        user.auth_token = nil
        o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
        user.auth_token = (0...20).map { o[rand(o.length)] }.join
        user.save
        #--------------------------------------------------
        render json: { status: 'SUCCESS', message: 'Solicitud eliminada', auth_token: user.auth_token }, status: :ok
      else
        render json: { status: 'INVALID', message: 'Token invalido'}, status: :unauthorized
      end
    end
  end
end
