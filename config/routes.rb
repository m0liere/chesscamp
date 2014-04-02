ChessCamp::Application.routes.draw do
  resources :users

  resources :students

  resources :registrations

  resources :locations

  resources :families

  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  # set the root url
  root to: 'home#index'

end
