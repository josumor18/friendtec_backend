Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace 'api' do
  #     namespace 'v1' do
  #       #resources :users
         post 'users/login', to: 'users#login'
  #       post 'users/login_token', to: 'users#login_token'
  #       post 'users/login_facebook', to: 'users#login_facebook'
  #       post 'users/register', to: 'users#register'
  #       get 'emisoras/index', to: 'emisoras#index'
  #       post 'ubicaciones/add', to: 'ubicaciones#add'
  #       get 'ubicaciones/get', to: 'ubicaciones#get'
  #       delete 'ubicaciones/del_ubicacion', to: 'ubicaciones#del_ubicacion'
  #       put 'users/change_pass', to: 'users#change_pass'
  #       put 'users/change_user', to: 'users#change_user'
  #       post 'user_emisoras/setSuscription', to: 'user_emisoras#setSuscription'
  #       get 'trendings/get', to: 'trendings#get'
  #       post 'trendings/add', to: 'trendings#add'
  #       put 'emisoras/change_emisora', to: 'emisoras#change_emisora'
  #       get 'user_emisoras/isSuscripted', to: 'user_emisoras#isSuscripted'
  #       delete 'user_emisoras/deleteSuscription', to: 'user_emisoras#deleteSuscription'
  #       get 'user_emisoras/getEmisorasFavoritas', to: 'user_emisoras#getEmisorasFavoritas'
  #       post 'votaciones/add_cancion', to: 'votaciones#add_cancion'
  #       post 'votaciones/add_voto', to: 'votaciones#add_voto'
  #       get 'votaciones/get_canciones', to: 'votaciones#get_canciones'
  #       get 'votaciones/get_mis_votos', to: 'votaciones#get_mis_votos'
  #       delete 'votaciones/del_voto', to: 'votaciones#del_voto'
  #       post 'votaciones/add_cancion', to: 'votaciones#add_cancion'
  #       post 'comentarios/add_comentarios', to: 'comentarios#add_comentarios'
  #       get 'comentarios/get_comentarios', to: 'comentarios#get_comentarios'
  #       delete 'votaciones/del_cancion', to: 'votaciones#del_cancion'
  #       post 'programacions/setProgramacion', to: 'programacions#setProgramacion'
  #       get 'programacions/getProgramacion', to: 'programacions#getProgramacion'
  #       get 'estadisticas/get_ubicaciones', to: 'estadisticas#get_ubicaciones'
  #       get 'estadisticas/get_votaciones', to: 'estadisticas#get_votaciones'
  #       delete 'programacions/deleteProgramacion', to: 'programacions#deleteProgramacion'
  #     end
     end
end
