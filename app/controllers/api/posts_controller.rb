module Api
  class PostsController <  ApplicationController
    protect_from_forgery with: :null_session

    def create
      user = User.where(id: params[:id]).first
      if(user.auth_token == params[:auth_token])
        post = Post.new(id_user: params[:id], contenido: params[:contenido], foto: params[:foto], fecha_hora: params[:fecha_hora])
        if (post.save)
          #---------- Cambiar authentication token ----------
          user.auth_token = nil
          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          user.auth_token = (0...20).map { o[rand(o.length)] }.join
          user.save
          #--------------------------------------------------
          render json: { status: 'SUCCESS', message: 'Post creado', auth_token: user.auth_token }, status: :ok
        else
          render json: { status: 'INVALID', message: 'Error al guardar post'}, status: :unauthorized
        end
      else
        render json: { status: 'INVALID', message: 'Token invalido'}, status: :unauthorized
      end
    end

    def get_friend_posts
      user = User.where(id: params[:id]).first
      if(user.auth_token == params[:auth_token])
        amigos = Amigo.where(id_user1: user.id)



        publicaciones = []
        posts = Post.all
        posts.each do |item|
          amigos.each do |item2|
            if(item2.id_user2 == item.id_user)
              publicaciones.push(item)
            end
          end
        end
        #---------- Cambiar authentication token ----------
        user.auth_token = nil
        o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
        user.auth_token = (0...20).map { o[rand(o.length)] }.join
        user.save
        #--------------------------------------------------
        render json: { status: 'SUCCESS', message: 'Posts obtenidos', posts: publicaciones, auth_token: user.auth_token }, status: :ok

      else
        render json: { status: 'INVALID', message: 'Token invalido'}, status: :unauthorized
      end
    end
  end
end