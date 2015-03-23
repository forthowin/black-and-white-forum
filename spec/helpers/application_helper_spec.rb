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

  describe "#normalize_post_number" do
    it "returns 1 for the first post on the first page" do
      params[:page] = 1
      expect(normalize_post_number(0)).to eq(1)
    end

    it "returns 11 for the first post on the scond page" do
      params[:page] = 2
      expect(normalize_post_number(0)).to eq(11)
    end

    it "returns 1 for the first post on the first page when viewing for the first time" do
      expect(normalize_post_number(0)).to eq(1)
    end
  end
end