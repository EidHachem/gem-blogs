require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Users' do
    it 'should returns http success, and view content' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Listing users')
      expect(response).to render_template(:index)
    end

    it 'returns http success, and view content' do
      get '/user/:id'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('User profile')
      expect(response).to render_template(:show)
    end
  end
end
