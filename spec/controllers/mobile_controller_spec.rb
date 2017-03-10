require 'rails_helper'

RSpec.describe MobileController, type: :controller do
  describe "GET #code with correct params" do
    it "returns http success" do
      get :code, params: { 'ios_code' => '1234' }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #code with incorrect params" do
    it "returns http not found" do
      get :code, params: { 'ios_code' => '4321' }
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
    it "returns http success" do
      get :cell
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #refresh" do
    it "returns http success" do
      get :refresh
      expect(response).to have_http_status(:success)
    end
  end

end
