Rails.application.routes.draw do
  resources :messages
  resources :chats
  resources :locations
  resources :notifications
  resources :solicituds
  resources :amigos
  resources :posts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace 'api' do
         post 'users/login', to: 'users#login'
         post 'users/login_token', to: 'users#login_token'
         get 'users/get_username_foto', to: 'users#get_username_foto'
         get 'users/search', to: 'users#search'
         post 'users/search_button', to: 'users#search_button'
         post 'posts/create', to: 'posts#create'
         get 'posts/get_friend_posts', to: 'posts#get_friend_posts'
         get 'amigos/get_amigos', to: 'amigos#get_amigos'
         post 'solicituds/create', to: 'solicituds#create'
         post 'solicituds/aceptar', to: 'solicituds#aceptar'
         delete 'solicituds/delete', to: 'solicituds#delete'
         get 'notifications/get', to: 'notifications#get'
         put 'notifications/set_false', to: 'notifications#set_false'
         get 'locations/get_friends_locations', to: 'locations#get_friends_locations'
         post 'locations/create', to: 'locations#create'
         post 'users/register', to: 'users#register'
         put 'users/change_user', to: 'users#change_user'
         put 'users/change_pass', to: 'users#change_pass'
         get 'posts/get_posts', to: 'posts#get_posts'
         get 'chats/get', to: 'chats#get'
         put 'chats/set_true', to: 'chats#set_true'
         get 'chats/get_chat_messages', to: 'chats#get_chat_messages'
         post 'chats/send_message', to: 'chats#send_message'
     end
end
