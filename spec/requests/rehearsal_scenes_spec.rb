require 'rails_helper'

RSpec.describe "RehearsalScenes", type: :request do
  describe "GET /rehearsal_scenes" do
    it "works! (now write some real specs)" do
      get rehearsal_scenes_path
      expect(response).to have_http_status(200)
    end
  end
end
