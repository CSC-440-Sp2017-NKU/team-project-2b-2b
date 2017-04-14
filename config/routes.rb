Rails.application.routes.draw do
  resources :courses
  resources :answers do
    member do
      put 'like', to: 'answers#upvote'
      put 'dislike', to: 'answers#downvote'
      put 'unlike', to: 'answers#unupvote'
      put 'undislike', to: 'answers#undownvote'
    end
  end
  resources :questions do
    member do
      put 'like', to: 'questions#upvote'
      put 'dislike', to: 'questions#downvote'
      put 'unlike', to: 'questions#unupvote'
      put 'undislike', to: 'questions#undownvote'
    end
  end

  get '/admin', to: 'admin#index'
  root to: 'admin#index'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users
end
