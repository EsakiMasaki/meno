Rails.application.routes.draw do

   devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do

    root to: "homes#top"
    get "about" => "homes#about"
    get "search" => "searches#search"

    resources :customers, only: [:index,:show,:edit,:update] do
      resource :relationships, only: [:create,:destroy]
      get "followings" => "relationships#followings",as: "followings"
      get "followers" => "relationships#followers",as: "followers"
    end

    resources :notes, only: [:new,:index,:show,:edit,:create,:update,:destroy] do
      resources :note_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
      get "favorite" => "favorites#favorite"
    end

    resources :categories, only: [:create,:destroy]

  end



  devise_for :admin,skip: [:passwords,:registrations], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
