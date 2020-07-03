Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    patch 'users/update', to: 'users/registrations#update'
    get 'addresses/edit', to: 'users/registrations#edit_address'
    patch 'addresses/update', to: 'users/registrations#update_address'
  end

  root 'items#index'

  resources :users do
    member do
      get 'listing'
      get 'completed'
      get 'purchase'
      get 'like'
      get 'all_items'
    end
  end  
  resources :items do
    collection do 
      get 'get_category_children', defaults: { format: 'json'}
      get 'get_category_grandchildren', defaults: { format: 'json'}
    end
    resources :purchase, only: :index do
      collection do
        post 'pay', to: 'purchase#pay'
      end
    end
  end
  resources :likes, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end

  resources :categories, only: [:new, :show]

end
