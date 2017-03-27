Rails.application.routes.draw do
  resources :answers do
    member do
      put 'like', to: 'answers#upvote'
      put 'dislike', to: 'answers#downvote'
    end
  end
  resources :questions
  root to: 'visitors#index'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users
end
