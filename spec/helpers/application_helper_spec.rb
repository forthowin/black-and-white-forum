require 'rails_helper'

describe ApplicationHelper do
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