require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  describe 'GET #index' do
    it 'should render correct partials' do
      render
      expect(view).to render_template(partial: '_header')
      expect(view).to render_template(partial: '_search_card')
    end
  end
end
