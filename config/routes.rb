Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
    get 'users', to: 'users/registrations#new'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users do
    collection do
    post '/:id/user_private' => 'users#user_private'
    end
  end

  root 'blogs#index'

  resources :blogs do
    resources :comments, only: :create
  end

  resources :users, only: [:show, :edit, :update] do
    resources :body_weights, only: [:index, :create, :update, :destroy]
    resources :bench_press_weight_records, only: [:index, :create, :update, :destroy]
    resources :dead_lift_weight_records, only: [:index, :create, :update, :destroy]
    resources :squat_weight_records, only: [:index, :create, :update, :destroy]
  end

  resources :users, only: :show

end
