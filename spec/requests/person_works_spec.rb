require 'rails_helper'

RSpec.describe "PersonWorks", type: :request do
  describe "GET /person_works" do
    it "works! (now write some real specs)" do
      get person_works_path
      expect(response).to have_http_status(200)
    end
  end
end
