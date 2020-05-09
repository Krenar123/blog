Rails.application.routes.draw do
  get '/articles', to: 'articles#index'
  # E njejta kjo ka me kriju te articles ama post nuk i perzin me get
  # we have the same route but controller(articles) and action is create...
  post '/articles', to: 'articles#create'
  get '/articles/new', to: 'articles#new', as: :new_article
  get '/articles/:id', to: 'articles#show', as: :article
  
  root to: 'articles#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
