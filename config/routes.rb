Rails.application.routes.draw do

  devise_for :admins, controllers: {
  	sessions: "admins/sessions",
  	passwords: "admins/passwords",
  }
  devise_for :customers, controllers: {
  	sessions: "customers/sessions",
  	passwords: "customers/passwords",
  	registrations: "customers/registrations"
  }

  ###admins
  namespace :admins do
    get "home/top" => "home#top"
    resources :products, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :ordered_products, only: [:update]
    resources :orders, only: [:index, :show, :update]
  end

  ###customers
    root "home#top"
    get "home/about" => "home#about"
    resources :products, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update] do
      member do
        get "bye_confirm"
        patch "bye_bye"
      end
    end
    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        get "thanks"
        get "confirm"
      end
    end
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :deliveries, except: [:new, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
