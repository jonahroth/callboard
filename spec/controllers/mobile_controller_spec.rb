require 'rails_helper'

RSpec.describe MobileController, type: :controller do
  let(:production) do
    Production.create!(title: 'Macbeth', ios_code: '1234',
                       ios_expiration: 7.days.from_now)
  end

  let(:person) do
    Person.create!(production: production, first: 'Jonah', last: 'Roth',
                   cell: '5555555555', email: 'test@example.com')
  end

  describe "GET #code with correct params" do
    it "returns http success" do
      get :code, params: { 'ios_code' => production.ios_code }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #code with incorrect params" do
    it "returns http not found" do
      get :code, params: { 'ios_code' => production.ios_code.next }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #code with no params" do
    it "returns http not found" do
      get :code
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #cell" do
    describe 'with correct params' do
      it "returns http success" do
        get :cell, params: { production_id: production.id, cell: person.cell,
                             uuid: 'aaa-bbb-ccc' }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'with invalid params' do
      it 'returns http bad request' do
        get :cell, params: { production_id: '-1', cell: '2', uuid: '' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    describe 'with no params' do
      it 'returns http bad request' do
        get :cell
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET #refresh" do
    before(:each) do
      person.ios_uuid = 'aaa-bbb-ccc'
      person.save!
    end

    describe 'with correct params' do
      it 'returns http success' do
        get :refresh, params: { production_id: production.id,
                                uuid: person.ios_uuid }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'with incorrect params' do
      it 'returns http not found' do
        get :refresh, params: { production_id: production.id + 1,
                                uuid: person.ios_uuid }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
