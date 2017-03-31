require 'rails_helper'

RSpec.describe "person_works/edit", type: :view do
  before(:each) do
    @person_work = assign(:person_work, PersonWork.create!(
      :person => nil,
      :work => nil
    ))
  end

  it "renders the edit person_work form" do
    render

    assert_select "form[action=?][method=?]", person_work_path(@person_work), "post" do

      assert_select "input#person_work_person_id[name=?]", "person_work[person_id]"

      assert_select "input#person_work_work_id[name=?]", "person_work[work_id]"
    end
  end
end
