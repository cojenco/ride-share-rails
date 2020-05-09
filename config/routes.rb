Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homepages#index"

  # resources :passengers
  # resources :drivers
  resources :trips, except: [:new, :index]

  resources :passengers do
    resources :trips, only: [:index, :new]
  end

  resources :drivers do
    resources :trips, only: [:index]
  end

  patch "/driver/:id/make_available", to: "drivers#make_available", as: "make_available"

end
