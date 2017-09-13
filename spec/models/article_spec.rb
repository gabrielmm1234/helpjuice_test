require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '.filter_by_name' do
    it 'should return articles with filtered by name' do
      Article.create!(name: 'How do I signup', search_times: 10, link: '')
      articles = Article.filter_by_name('How do I')
      expect(articles.first.name).to eq('How do I signup')
    end
  end
end
