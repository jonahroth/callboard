Rails.application.routes.draw do
  root 'schedules#new'
  resources :schedules
end
