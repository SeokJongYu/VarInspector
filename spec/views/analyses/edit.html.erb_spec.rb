require 'rails_helper'

RSpec.describe "analyses/edit", type: :view do
  before(:each) do
    @analysis = assign(:analysis, Analysis.create!(
      :name => "MyString",
      :descriptioni => "MyText",
      :seq_blood1 => "MyText",
      :seq_blood2 => "MyText",
      :seq_brain1 => "MyText",
      :seq_brain2 => "MyText",
      :project => nil
    ))
  end

  it "renders the edit analysis form" do
    render

    assert_select "form[action=?][method=?]", analysis_path(@analysis), "post" do

      assert_select "input[name=?]", "analysis[name]"

      assert_select "textarea[name=?]", "analysis[descriptioni]"

      assert_select "textarea[name=?]", "analysis[seq_blood1]"

      assert_select "textarea[name=?]", "analysis[seq_blood2]"

      assert_select "textarea[name=?]", "analysis[seq_brain1]"

      assert_select "textarea[name=?]", "analysis[seq_brain2]"

      assert_select "input[name=?]", "analysis[project_id]"
    end
  end
end
