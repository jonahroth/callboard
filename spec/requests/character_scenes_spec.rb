require 'rails_helper'

RSpec.describe "CharacterScenes", type: :request do
  describe "GET /character_scenes" do
    it "works! (now write some real specs)" do
      get character_scenes_path
      expect(response).to have_http_status(200)
    end
  end
end
