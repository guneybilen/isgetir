require 'test_helper'

class JobTest < ActiveSupport::TestCase

  test "should create job" do
    job = Job.new
    job.user = users(:lauren)
    job.title = "Makinist"
    job.body = "is"
    assert job.save
  end

  test "should find job" do
    job_id = jobs(:makinist).id
    assert_nothing_raised { Job.find(job_id) }
  end

  test "should update job" do
    job = jobs(:makinist)
    assert job.update_attributes(:title => 'New title')
  end

  test "should destroy job" do
    job = jobs(:makinist)
    job.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Job.find(job.id) }
  end

  test "should not create an job without title nor body" do
    job = Job.new
    assert !job.valid?
    assert job.errors[:title].any?
    assert job.errors[:body].any?
    assert_equal ["can't be blank"], job.errors[:title]
    assert_equal ["can't be blank"], job.errors[:body]
    assert !job.save
  end
end

