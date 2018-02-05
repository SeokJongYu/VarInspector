require 'rails_helper'

RSpec.describe "analyses/index", type: :view do
  before(:each) do
    assign(:analyses, [
      Analysis.create!(
        :name => "Name",
        :descriptioni => "MyText",
        :seq_blood1 => "MyText",
        :seq_blood2 => "MyText",
        :seq_brain1 => "MyText",
        :seq_brain2 => "MyText",
        :project => nil
      ),
      Analysis.create!(
        :name => "Name",
        :descriptioni => "MyText",
        :seq_blood1 => "MyText",
        :seq_blood2 => "MyText",
        :seq_brain1 => "MyText",
        :seq_brain2 => "MyText",
        :project => nil
      )
    ])
  end

  it "renders a list of analyses" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
