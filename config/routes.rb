Rails.application.routes.draw do
  root 'schedules#new'

  get 'current_user' => 'application#current'

  get  'api/mobile/code'    => 'mobile#code'
  post 'api/mobile/cell'    => 'mobile#cell'
  get  'api/mobile/refresh' => 'mobile#refresh'

  get 'works/all_fits/:id' => 'works#all_fits'

  # TODO: get rid of this
  get 'generate' => 'schedules#generate'

  resources :rehearsals
  resources :conflicts
  resources :productions
  resources :people
  resources :schedules
  resources :person_works
  resources :works

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
end
