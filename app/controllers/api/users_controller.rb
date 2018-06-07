module Api
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session
      def login
        #email = params[:email]
        user = User.where(carnet: params[:carnet]).first
        pass = params[:password]
        if (user && user.password == pass)
          #---------- Cambiar authentication token ----------
          user.auth_token = nil
          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          user.auth_token = (0...20).map { o[rand(o.length)] }.join
          user.save
          #--------------------------------------------------
          render json: { status: 'SUCCESS', message: 'SESION INICIADA', data:user }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al iniciar sesion'}, status: :unauthorized
        end
      end

      def login_token
        #email = params[:email]
        user = User.where(carnet: params[:carnet]).first
        pass = params[:auth_token]
        if (user && user.auth_token == pass)
          #---------- Cambiar authentication token ----------
          user.auth_token = nil
          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          user.auth_token = (0...20).map { o[rand(o.length)] }.join
          user.save
          #--------------------------------------------------
          render json: { status: 'SUCCESS', message: 'SESION INICIADA', data:user }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al iniciar sesion'}, status: :unauthorized
        end
      end

      def get_username_foto
        user = User.where(id: params[:id_user]).first
        if(user)
          render json: { status: 'SUCCESS', message: 'DATOS OBTENIDOS', username: user.nombre, foto: user.rfoto }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al obtener los datos de usuario'}, status: :unauthorized
        end
      end

      def search
        user = User.where(id: params[:id]).first
        pass = params[:auth_token]
        busqueda = params[:busqueda]
        if (user && user.auth_token == pass)
          usuarios = User.all
          resultados = []
          usuarios.each do |usuario|
            if((usuario.nombre).include? busqueda)
              resultados.push(usuario)
            end
          end
          #---------- Cambiar authentication token ----------
          user.auth_token = nil
          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          user.auth_token = (0...20).map { o[rand(o.length)] }.join
          user.save
          #--------------------------------------------------
          render json: { status: 'SUCCESS', message: 'RESULTADOS OBTENIDOS', resultados: resultados, auth_token: user.auth_token }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al obtener los resultados de busqueda'}, status: :unauthorized
        end
      end
    end
end
