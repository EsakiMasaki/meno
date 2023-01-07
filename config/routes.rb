Rails.application.routes.draw do

  root to: "public/homes#top"
  get "about" => "public/homes#about"
  get "search" => "public/searches#search"

  resources :customers, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get "followings" => "public/relationships#followings",as: "followings"
    get "followers" => "public/relationships#followers",as: "followers"
  end

  resources :notes, only: [:new,:index,:show,:edit,:create,:update,:destroy] do
    resources :note_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
    get "favorite" => "public/favorites#favorite"
  end

  resources :categories, only: [:create,:destroy]


  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin,skip: [:passwords,:registrations], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
