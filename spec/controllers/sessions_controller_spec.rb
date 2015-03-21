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
      expect(response).to redirect_to topics_path
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "sets the session id to the sign in user id" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password
        expect(session[:user_id]).to eq(bob.id)
      end

      it "redirects to the forum path" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password
        expect(response).to redirect_to topics_path
      end

      it "sets the flash success message" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      it "does not set the session id" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password + "asdf"
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the login path" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password + "asdf"
        expect(response).to redirect_to login_path
      end

      it "sets the flash danger message" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password + "asdf"
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "GET destroy" do
    it "redirects to the root path" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      get :destroy
      expect(response).to redirect_to root_path
    end

    it "sets the session id to nil" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "sets the flash success message" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      get :destroy
      expect(flash[:success]).to be_present
    end
  end
end