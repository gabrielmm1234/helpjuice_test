# Controller related to Article actions.
class ArticlesController < ApplicationController
  # GET /search_article/:name
  def search_article
    Article.new.process_article_query(params[:name])
    @articles = Article.all
    render json: @articles
  end
end
