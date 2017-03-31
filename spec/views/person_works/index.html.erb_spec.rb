require 'rails_helper'

RSpec.describe "person_works/index", type: :view do
  before(:each) do
    assign(:person_works, [
      PersonWork.create!(
        :person => nil,
        :work => nil
      ),
      PersonWork.create!(
        :person => nil,
        :work => nil
      )
    ])
  end

  it "renders a list of person_works" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
