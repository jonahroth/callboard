require 'rails_helper'

RSpec.describe "CrewCalls", type: :request do
  describe "GET /crew_calls" do
    it "works! (now write some real specs)" do
      get crew_calls_path
      expect(response).to have_http_status(200)
    end
  end
end
