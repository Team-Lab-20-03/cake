Rails.application.routes.draw do

  devise_for :admins, controllers: {
  	sessions: "admins/sessions",
  	passwords: "admins/passwords",
  }
  devise_for :customers, controllers: {
  	sessions: "customers/sessions", #sign_in.sign_up
  	passwords: "customers/passwords", #パスワード画面
  	registrations: "customers/registrations" #登録画面
  }

  ###admins
  namespace :admins do #namespace(admins/~)
    get "home/top" => "home#top" #home(controller)のtop(action)
    resources :products, except: [:destroy] #destroyを除く
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :ordered_products, only: [:update] #更新のみ
    resources :orders, only: [:index, :show, :update]
  end

  ###customers
    root "home#top" #URL指定なしで飛ぶ
    get "home/notice" => "home#notice" #home(controller)のnotice(action)
    resources :products, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update] do
      member do #入れ子で特定のidを伴う場合(member) ※idを付与させてる(root設定)
        get "bye_confirm" #get(そこのページへ飛ぶ)
        patch "bye_bye" #update(書き換える)
      end
    end
    resources :orders, only: [:index, :show, :new, :create] do
      collection do #入れ子で特定のidが必要ない場合(collection) idは付与させてない
        get "thanks"
        get "confirm"
      end
    end
    delete "cart_items/destroy_all" => "cart_items#destroy_all" #URLを作成
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :deliveries, except: [:new, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
