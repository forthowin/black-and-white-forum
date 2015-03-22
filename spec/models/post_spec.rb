require 'rails_helper'

describe Post do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:user) }
  it { should belong_to(:subject) }
end