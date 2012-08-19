require "spec_helper"

describe Notifier do
  describe "email_friend" do
    let(:mail) { Notifier.email_friend }

    it "renders the headers" do
      mail.subject.should eq("Email friend")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
