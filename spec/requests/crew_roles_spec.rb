require 'rails_helper'

RSpec.describe "CrewRoles", type: :request do
  describe "GET /crew_roles" do
    it "works! (now write some real specs)" do
      get crew_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
