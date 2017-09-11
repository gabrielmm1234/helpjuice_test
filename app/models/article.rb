# Model that represents an article and it's actions.
class Article < ApplicationRecord
  ARTICLE_REGEX = /How do I .+|What is my .+|How can I .+|How to .+|What do I .+/

  def process_article_query(article_input)
    article_by_name = Article.by_name(article_input)
    if article_by_name.blank?
      match_article_input(article_input)
    else
      add_search_times(article_by_name)
    end
  end

  def self.by_name(name)
    find_by(name: name)
  end

  def self.retrieve_article_data
    articles = Article.all
    filtered_articles = []
    articles.each do |article|
      data = {}
      data[:name] = article.name
      data[:y] = article.search_times
      filtered_articles << data
    end
    filtered_articles
  end

  private

  def add_search_times(article)
    article.update(search_times: article.search_times + 1)
  end

  def match_article_input(article_name)
    match_data = article_name.match(ARTICLE_REGEX)
    if match_data.present?
      save_article(article_name)
    else
      process_unmatched_input(article_name)
    end
  end

  def process_unmatched_input(article_name)
    split_article = article_name.gsub(/\s+/m, ' ').strip.split(' ')
    save_article(article_name) if split_article.size > 4
  end

  def save_article(article_name)
    article = Article.new(name: article_name, search_times: 1, link: '')
    article.save
  end
end
