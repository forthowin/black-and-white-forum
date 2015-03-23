require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    it "sets @user as new User" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "redirects to forum path for users that are already signed in" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      get :new
      expect(response).to redirect_to forum_path
    end
  end

  describe "POST create" do
    let(:bob) { Fabricate(:user) }

    context "with valid input" do
      before { post :create, username: bob.username, password: bob.password }

      it "sets the session id to the sign in user id" do
        expect(session[:user_id]).to eq(bob.id)
      end

      it "redirects to the forum path" do
        expect(response).to redirect_to forum_path
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      before { post :create, username: bob.username, password: bob.password + "asdf" }
      it "does not set the session id" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the login path" do
        expect(response).to redirect_to login_path
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "GET destroy" do
    let(:bob) { Fabricate(:user) }

    it "redirects to the root path" do
      session[:user_id] = bob.id
      get :destroy
      expect(response).to redirect_to root_path
    end

    it "sets the session id to nil" do
      session[:user_id] = bob.id
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "sets the flash success message" do
      session[:user_id] = bob.id
      get :destroy
      expect(flash[:success]).to be_present
    end

    it "redirects to the login page for unauthenticated users" do
      get :destroy
      expect(response).to redirect_to login_path
    end
  end
end