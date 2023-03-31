Rails.application.routes.draw do
  devise_for :users
  get 'pages/home'
  namespace :user do
    resources :rooms
    get 'chats/page', to:"chats#page", as:"chat_page"
    resources :chats
    resources :comments
    resources :chat_likes, only:[:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
