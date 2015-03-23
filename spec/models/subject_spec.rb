require 'rails_helper'

describe Subject do
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:topic_id) }
  it { should have_many(:posts) }

  describe "#recent_post_user" do
    let(:bob) { Fabricate(:user, username: 'bob') }
    let(:topic) { Fabricate(:topic) }
    let(:subject) { Fabricate(:subject, user: bob, topic: topic) }

    it "returns the subject creator if there are no posts" do
      expect(subject.recent_post_user).to eq(bob)
    end

    it "returns the most recent post creator's username" do
      bill = Fabricate(:user, username: 'bill')
      post1 = Fabricate(:post, user: bob, subject: subject)
      post2 = Fabricate(:post, user: bill, subject: subject)
      expect(subject.recent_post_user).to eq(bill)
    end
  end
end