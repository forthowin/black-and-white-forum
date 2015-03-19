require 'rails_helper'

describe ApplicationController do
  describe "#logged_in?" do
    it "returns true if a user is logged in" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      expect(subject.logged_in?).to be_truthy
    end

    it "returns false if a user is not logged in" do
      expect(subject.logged_in?).to be_falsey
    end
  end

  describe "#current_user" do
    it "returns the current user in the session" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      expect(subject.current_user).to eq(bob)
    end

    it "returns nil if there is no user in the session" do
      expect(subject.current_user).to be_nil
    end
  end
end