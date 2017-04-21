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

  resources :notes
  resources :rehearsal_scenes
  resources :rehearsals
  resources :scenes
  resources :conflicts
  resources :productions
  resources :people
  resources :schedules
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
end
