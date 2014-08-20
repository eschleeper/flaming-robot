Rails.application.routes.draw do
  
  resources :re_tweets do
    collection do
      get 'search'
    end
    member do
      post 'send_retweet'
    end
  end

  resources :guides

  resources :critters do 
    resources :identifying_images
    collection do
      get 'search'
    end
  end
  resources :birds,       controller: 'critters', type: 'Bird'
  resources :bugs,        controller: 'critters', type: 'Bug'
  resources :herps,        controller: 'critters', type: 'Herp'
  resources :insects,     controller: 'critters', type: 'Insect'
  resources :mammals,     controller: 'critters', type: 'Mammal'

  resources :plants
  
  resources :guides
  resources :sections
  resources :guide_items

  devise_for :explorers

  root 'index#index'

end
