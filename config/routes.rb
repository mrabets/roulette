Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

  namespace :api do
    namespace :v1 do
      post 'payment/create'
      get "users/:id/balance", to: 'payment#balance'
    end
  end
end
