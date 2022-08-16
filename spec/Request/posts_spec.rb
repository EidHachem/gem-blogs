require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'Posts' do
    it 'should returns http success, and view content' do
      get '/user/:id/post/'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('User posts')
      expect(response).to render_template(:posts)
    end

    it 'returns http success, and view content' do
      get '/user/:id/post/:id'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Post details')
      expect(response).to render_template(:post)
    end
  end
end
