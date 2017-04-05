Rails.application.routes.draw do
  resources :person_works
  resources :works
  get 'static_pages/index'
  root 'static_pages#index'

  get 'current_user' => 'static_pages#current'

  get  'api/mobile/code'    => 'mobile#code'
  post 'api/mobile/cell'    => 'mobile#cell'
  get  'api/mobile/refresh' => 'mobile#refresh'

  # TODO: get rid of this
  get 'generate' => 'schedules#generate'

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
  resources :schedules
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
end
