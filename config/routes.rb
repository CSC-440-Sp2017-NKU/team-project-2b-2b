Rails.application.routes.draw do
  resources :courses
  resources :answers do
    member do
      put 'like', to: 'answers#upvote'
      put 'dislike', to: 'answers#downvote'
    end
  end
  resources :questions do
    member do
      put 'like', to: 'questions#upvote'
      put 'dislike', to: 'questions#downvote'
    end
  end
  root to: 'courses#index'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users
end
