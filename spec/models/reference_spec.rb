require 'spec_helper'

describe Reference do
  before :each do
    @ref = Reference.create!()
  end

  it 'should respond to' do
    @ref.should respond_to(:job)
  end
end


