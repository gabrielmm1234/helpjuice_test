Rails.application.routes.draw do
  root 'home#index'

  # Article Search
  get '/search_article/:name' => 'articles#search_article'
end
