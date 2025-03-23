Rails.application.routes.draw do #to rails 
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  root "application#hello"
end
