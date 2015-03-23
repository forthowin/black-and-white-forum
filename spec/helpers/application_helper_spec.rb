require 'rails_helper'

describe ApplicationHelper do
  describe "#time_difference" do
    let(:bob) { Fabricate(:user) }
    let(:topic) { Fabricate(:topic) }

    it "returns a created ago string in seconds" do
      subject = Fabricate(:subject, user: bob, topic: topic, created_at: 1.second.ago)
      expect(time_difference(subject.created_at)).to eq("1 second ago")
    end

    it "pluralizes seconds if it is greater than 1" do
      subject = Fabricate(:subject, user: bob, topic: topic, created_at: 2.second.ago)
      expect(time_difference(subject.created_at)).to eq("2 seconds ago")
    end
  end
end