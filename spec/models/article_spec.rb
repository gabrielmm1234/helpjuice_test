require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '.filter_by_name' do
    it 'should return articles filtered by name' do
      Article.create!(name: 'How do I signup', search_times: 10, link: '')
      articles = Article.filter_by_name('How do I')
      expect(articles.first.name).to eq('How do I signup')
    end
  end

  describe '.by_name' do
    it 'should return one article filtered by name' do
      Article.create!(name: 'How do I signup', search_times: 10, link: '')
      articles = Article.by_name('How do I signup')
      expect(articles.name).to eq('How do I signup')
    end
  end

  describe '.retrieve_article_data' do
    it 'should return an array with search_times for each article' do
      Article.create!(name: 'How do I signup', search_times: 10, link: '')
      articles = Article.retrieve_article_data
      expect(articles).to eq([{ name: 'How do I signup', y: 10 }])
    end
  end

  describe '.process_article_query' do
    it 'should process article query and save it with one search' do
      Article.new.process_article_query('How do I signup')
      expect(Article.first.name).to eq('How do I signup')
    end

    it 'should process article query and update it with one more search' do
      Article.create!(name: 'How do I signup', search_times: 10, link: '')
      Article.new.process_article_query('How do I signup')
      expect(Article.first.search_times).to eq(11)
    end

    it 'should process unmatched article query and save it with one search' do
      Article.new.process_article_query('I want to cancel my subscription')
      expect(Article.first.name).to eq('I want to cancel my subscription')
      expect(Article.first.search_times).to eq(1)
    end

    it 'should process unmatched article query and not save it' do
      Article.create!(name: 'How do I signup', search_times: 10, link: '')
      Article.new.process_article_query('I want to')
      expect(Article.last.name).not_to eq('I want to')
    end
  end
end
