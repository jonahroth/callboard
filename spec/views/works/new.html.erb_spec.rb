require 'rails_helper'

RSpec.describe "works/new", type: :view do
  before(:each) do
    assign(:work, Work.new(
      :name => "MyString",
      :type => "",
      :duration => 1,
      :break_duration => 1
    ))
  end

  it "renders new work form" do
    render

    assert_select "form[action=?][method=?]", works_path, "post" do

      assert_select "input#work_name[name=?]", "work[name]"

      assert_select "input#work_type[name=?]", "work[type]"

      assert_select "input#work_duration[name=?]", "work[duration]"

      assert_select "input#work_break_duration[name=?]", "work[break_duration]"
    end
  end
end
