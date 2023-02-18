Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get  'static_pages/contact'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
