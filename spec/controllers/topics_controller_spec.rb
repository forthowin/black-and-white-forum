require 'rails_helper'

describe TopicsController do
  describe "GET index" do
    it "sets @topics to all the Topic for authenticated users" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      topic1 = Fabricate(:topic)
      topic2 = Fabricate(:topic)
      get :index
      expect(assigns(:topics)).to eq(Topic.all)
    end

    it "redirects to login path for unauthenticated users" do
      get :index
      expect(response).to redirect_to login_path
    end
  end
end