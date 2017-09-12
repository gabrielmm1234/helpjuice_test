Rails.application.routes.draw do
  root 'home#index'

  # Article
  delete 'articles/destroy', to: 'articles#clear_stats'

  # Article Search
  get '/search_article/:name' => 'articles#search_article'

  # Article chart
  get '/article/chart', to: 'articles#chart_information',
                        as: 'chart_information_path'
  get '/article/info', to: 'articles#retrieve_article_info'
end
