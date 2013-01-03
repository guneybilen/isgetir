require 'spec_helper'

describe Comment do
  before :each do
    @com = Comment.create(name: "hasan ali", body: "iyi is")
  end

  it 'should respond to' do
    @com.should respond_to(:job)
  end
end
