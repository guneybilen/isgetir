require 'test_helper'

class JobTest < ActiveSupport::TestCase

  test "should create skill" do
    job = Job.new
    job.user = users(:lauren)
    job.title = "Makinist"
    job.body = "is"
    assert job.save
  end
end
