require "api_constraints"

Rails.application.routes.draw do
  get 'health' => 'health#show'

  namespace :api, defaults: { format: :json } do
    scope module: :v1, 
      constraints: ApiConstraints.new(version: 1, default: true) do

      resources :users
    end
  end
end
