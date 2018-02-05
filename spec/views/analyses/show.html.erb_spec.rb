require 'rails_helper'

RSpec.describe "analyses/show", type: :view do
  before(:each) do
    @analysis = assign(:analysis, Analysis.create!(
      :name => "Name",
      :descriptioni => "MyText",
      :seq_blood1 => "MyText",
      :seq_blood2 => "MyText",
      :seq_brain1 => "MyText",
      :seq_brain2 => "MyText",
      :project => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
