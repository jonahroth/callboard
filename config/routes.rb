Rails.application.routes.draw do
  get  'api/mobile/code'    => 'mobile#code'
  post 'api/mobile/cell'    => 'mobile#cell'
  get  'api/mobile/refresh' => 'mobile#refresh'

  resources :check_ins
  resources :crew_calls
  resources :department_notes
  resources :departments
  resources :crew_roles
  resources :notes
  resources :rehearsal_scenes
  resources :rehearsals
  resources :character_scenes
  resources :scenes
  resources :conflicts
  resources :characters
  resources :productions
  resources :people
  devise_for :users
  root 'schedules#new'
  resources :schedules
end
