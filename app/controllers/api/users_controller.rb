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
          estado_amistad = []
          usuarios.each do |usuario|
            if(usuario.id != user.id && (((usuario.nombre).downcase).include? busqueda.downcase))
              resultados.push(usuario)

              # est: Estado de la amistad (0: No amigos; 1: Amigos; 2: Solicitud hecha; 3: Solicitud recibida)
              est = 0
              amig = Amigo.where(id_user1: user.id).where(id_user2: usuario.id).first
              if(amig)
                est = 1
              else
                soli = Solicitud.where(id_user1: user.id).where(id_user2: usuario.id).first
                if(soli)
                  est = 2
                else
                  soli = Solicitud.where(id_user1: usuario.id).where(id_user2: user.id).first
                  if(soli)
                    est = 3
                  end
                end
              end

              estado_amistad.push(est)
            end
          end
          #---------- Cambiar authentication token ----------
          user.auth_token = nil
          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          user.auth_token = (0...20).map { o[rand(o.length)] }.join
          user.save
          #--------------------------------------------------
          render json: { status: 'SUCCESS', message: 'RESULTADOS OBTENIDOS', resultados: resultados, estados_amistad: estado_amistad, auth_token: user.auth_token }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al obtener los resultados de busqueda'}, status: :unauthorized
        end
      end

      def search_button
        user = User.where(id: params[:id]).first
        if (user)
          accion = params[:accion]
          if (accion == '0')
            solicitud = Solicitud.new(id_user1: params[:id], id_user2: params[:id_user2])
            solicitud.save
          elsif (accion == '1')
            Amigo.where(id_user1: user.id).where(id_user2: params[:id_user2]).destroy_all
            Amigo.where(id_user1: params[:id_user2]).where(id_user2: user.id).destroy_all
          elsif (accion == '2')
            amigo1 = Amigo.new(id_user1: params[:id], id_user2: params[:id_user2])
            amigo2 = Amigo.new(id_user1: params[:id_user2], id_user2: params[:id])
            amigo1.save
            amigo2.save
          end
          render json: { status: 'SUCCESS', message: 'ACCION EXITOSA' }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al obtener los resultados de busqueda'}, status: :unauthorized
        end
      end
    end
end
