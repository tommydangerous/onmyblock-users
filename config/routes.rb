Rails.application.routes.draw do
  get "health" => "health#show"

  # Add application specific routes below this line
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :authentications, only: [] do
        collection do
          post :login, path: "/"
          delete :logout, path: "/"
        end
      end
      resources :credentials, only: :update
      resources :users, only: %i(create update)
    end
  end
end
