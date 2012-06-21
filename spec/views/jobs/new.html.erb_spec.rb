require 'spec_helper'

describe "skills/new.html.erb" do
  before(:each) do
    assign(:job, stub_model(Job,
      :title => "MyString",
      :location => "MyString",
      :reference => "MyString",
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new skill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => skills_path, :method => "post" do
      assert_select "input#skill_title", :name => "skill[title]"
      assert_select "input#skill_location", :name => "skill[location]"
      assert_select "input#skill_reference", :name => "skill[reference]"
      assert_select "textarea#skill_body", :name => "skill[body]"
    end
  end
end
