Rails.application.routes.draw do
  get 'health' => 'health#show'

  resources :users, defaults: { format: :json }
end
