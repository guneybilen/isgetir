require 'spec_helper'

describe "skills/edit.html.erb" do
  before(:each) do
    @skill = assign(:skill, stub_model(Skill,
      :new_record? => false,
      :title => "MyString",
      :location => "MyString",
      :reference => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit skill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => skill_path(@skill), :method => "post" do
      assert_select "input#skill_title", :name => "skill[title]"
      assert_select "input#skill_location", :name => "skill[location]"
      assert_select "input#skill_reference", :name => "skill[reference]"
      assert_select "textarea#skill_body", :name => "skill[body]"
    end
  end
end
