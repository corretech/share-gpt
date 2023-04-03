Rails.application.routes.draw do
  namespace :user do
  end
  root :to => 'user/homes#index'
  devise_for :users
  get 'pages/home'
  namespace :user do
    get 'homes/page', to:"homes#page", as:"home_page"
    get 'homes/index'
    get 'rooms/page', to:"rooms#page", as:"room_page"
    resources :rooms
    get 'chats/page', to:"chats#page", as:"chat_page"
    get 'chats/sequels/:id', to:"chats#sequels", as:"chat_sequels"
    get 'chats/comments/:id', to:"chats#comments", as:"chat_bottoms"
    resources :chats
    get 'comments/page', to:"comments#page", as:"comment_page"
    resources :comments
    resources :comment_likes, only:[:create]
    resources :chat_likes, only:[:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
