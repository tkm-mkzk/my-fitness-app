Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'blogs#index'

  resources :blogs do
    resources :comments, only: :create
  end

  resources :users, only: [:show, :edit, :update] do
    resources :body_weights, only: [:index, :create, :update, :destroy]
    resources :bench_press_weight_records, only: [:index, :create, :update, :destroy]
    resources :dead_lift_weight_records, only: [:index, :create, :update, :destroy]
  end

end
