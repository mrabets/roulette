Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  namespace :api do
    namespace :v1 do
      post 'payment/create'
      put 'payment/update'
      get 'users/:id/balance', to: 'payment#balance'
    end
  end
end
