require 'rails_helper'

RSpec.describe "DepartmentNotes", type: :request do
  describe "GET /department_notes" do
    it "works! (now write some real specs)" do
      get department_notes_path
      expect(response).to have_http_status(200)
    end
  end
end
