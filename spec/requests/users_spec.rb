# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users" do
  describe "create" do
    subject(:make_request) do
      post api_v1_users_path, params:
    end

    let(:params) {}

    context 'when valid params are provided' do
      let(:params) {
        {
          user: {
            name: 'Harry Potter',
            email: 'harry@griffindor.com',
            phone: '2547123456',
            password: 'test123',
            password_confirmation: 'test123'
          }
        }
      }

      it 'returns a 201' do
        make_request
        expect(response).to have_http_status(:created)
      end

      it 'returns a success message' do
        make_request
        expect(json_response[:message]).to eq('User has been created successfully')
      end

      it 'creates the user' do
        expect { make_request }.to change(User, :count).by(1)
      end
    end

    context 'when invalid params are provided' do
      let(:params) {
        {
          user: {
            name: 'Harry Potter',
            email: 'harry@griffindor.com'
          }
        }
      }

      it 'returns a 422' do
        make_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        make_request
        expect(json_response[:message]).to eq('We were unable to create your account')
      end

      it 'does not create the user' do
        expect { make_request }.not_to change(User, :count)
      end
    end
  end
end
