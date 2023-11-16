Rails.application.routes.draw do
  namespace :public do
    get 'notifications/index'
    get 'notifications/destroy'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  
}
  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only:[:index, :show, :edit, :update]
    get 'search' => 'searches#search'
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    get 'search' => 'searches#search'
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :favorites
      get 'unsubscribe'
      patch 'withdraw'
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end
  
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:index, :create, :destroy] 
      resources :comments, only: [:create, :destroy]
    end
    resources :reports, only: [:new, :create] 
    resources :notifications, only: [:index, :destroy]
  end
  
end
