require 'spec_helper'

describe "skills/index.html.erb" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
        :title => "Title",
        :location => "Location",
        :reference => "Reference",
        :body => "MyText"
      ),
      stub_model(Job,
        :title => "Title",
        :location => "Location",
        :reference => "Reference",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of skills" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Reference".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
