require 'rails_helper'

RSpec.describe "person_works/show", type: :view do
  before(:each) do
    @person_work = assign(:person_work, PersonWork.create!(
      :person => nil,
      :work => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
