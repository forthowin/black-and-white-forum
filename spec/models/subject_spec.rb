require 'rails_helper'

describe Subject do
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:topic_id) }
  it { should have_many(:posts) }
end