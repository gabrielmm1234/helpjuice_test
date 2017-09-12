require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #chart_information' do
    it 'returns http success' do
      get :chart_information
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #clear_stats' do
    it 'should clear stats related to all articles' do
      Article.create!(name: 'Test', search_times: 10, link: '')
      delete :clear_stats
      expect(Article.first.search_times).to eq(0)
    end
  end

  describe 'GET #retrieve_article_info' do
    it 'should respond with a JSON' do
      get :retrieve_article_info
      expect(response.header['Content-Type']).to eq 'application/json; charset=utf-8'
    end

    it 'should respond an array with article information' do
      Article.create!(name: 'Test', search_times: 10, link: '')
      get :retrieve_article_info
      info = JSON.parse response.body

      expect(info.first['name']).to eq('Test')
      expect(info.first['y']).to eq(10)
    end
  end

  describe 'GET #search_article' do
    it 'should respond with a JSON' do
      get :search_article, params: { name: 'How do I' }
      expect(response.header['Content-Type']).to eq 'application/json; charset=utf-8'
    end

    it 'should save matched article name with more than 4 words' do
      Article.create!(name: 'Test', search_times: 10, link: '')
      get :search_article, params: { name: 'How do I cancel my subscription' }
      expect(Article.last.name).to eq('How do I cancel my subscription')
    end

    it 'should not save unmatched article name with less than 4 words' do
      Article.create!(name: 'Test', search_times: 10, link: '')
      get :search_article, params: { name: 'How do I' }
      expect(Article.last.name).not_to eq('How do I')
    end

    it 'should save unmatched article name with more than 4 words' do
      get :search_article, params: { name: 'I want to cancel my subscription' }
      expect(Article.last.name).to eq('I want to cancel my subscription')
    end

    it 'should return articles with How do I string' do
      Article.create!(name: 'How do I cancel my subscription', search_times: 10, link: '')
      get :search_article, params: { name: 'How do I' }
      articles = JSON.parse response.body
      expect(articles.first['name']).to eq('How do I cancel my subscription')
    end
  end
end
