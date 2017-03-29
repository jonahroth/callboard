require 'rails_helper'

RSpec.describe "works/index", type: :view do
  before(:each) do
    assign(:works, [
      Work.create!(
        :name => "Name",
        :type => "Type",
        :duration => 2,
        :break_duration => 3
      ),
      Work.create!(
        :name => "Name",
        :type => "Type",
        :duration => 2,
        :break_duration => 3
      )
    ])
  end

  it "renders a list of works" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
