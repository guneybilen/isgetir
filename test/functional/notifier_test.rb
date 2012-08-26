require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "email_friend" do
    job = jobs(:makinist)
    message = Notifier.email_friend(job, 'John Smith', 'dude@example.com')

    assert_equal "Interesting Job", message.subject
    assert_equal ["dude@example.com"], message.to
    assert_equal ["admin@isgetir.com"], message.from
  end
end
