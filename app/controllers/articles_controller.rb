# Controller related to Article actions.
class ArticlesController < ApplicationController
  # GET /search_article/:name
  def search_article
    Article.new.process_article_query(params[:name])
    @articles = Article.filter_by_name(params[:name]).order(search_times: :desc)
    render json: @articles
  end

  # GET /article/chart
  def chart_information; end

  # GET /article/info
  def retrieve_article_info
    @articles = Article.retrieve_article_data
    render json: @articles
  end

  # DELETE 'articles/destroy'
  def clear_stats
    Article.update_all search_times: 0
  end
end
