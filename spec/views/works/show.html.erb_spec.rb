require 'rails_helper'

RSpec.describe "works/show", type: :view do
  before(:each) do
    @work = assign(:work, Work.create!(
      :name => "Name",
      :type => "Type",
      :duration => 2,
      :break_duration => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
