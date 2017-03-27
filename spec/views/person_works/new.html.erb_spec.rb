require 'rails_helper'

RSpec.describe "person_works/new", type: :view do
  before(:each) do
    assign(:person_work, PersonWork.new(
      :person => nil,
      :work => nil
    ))
  end

  it "renders new person_work form" do
    render

    assert_select "form[action=?][method=?]", person_works_path, "post" do

      assert_select "input#person_work_person_id[name=?]", "person_work[person_id]"

      assert_select "input#person_work_work_id[name=?]", "person_work[work_id]"
    end
  end
end
