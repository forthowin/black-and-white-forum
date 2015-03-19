require "rails_helper"

describe UsersController do
  describe "GET new" do
    it "assigns @user as a new User" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "redirects to the root path for users that is already log in"
  end

  describe "POST create" do
    context "with valid input" do
      it "creates a new user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it "sets the flash success message" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success]).to be_present
      end

      it "saves the user into the session" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(session[:user_id]).to be_present
      end

      it "redirects to the forum page"
    end

    context "with invalid input" do
      it "does not create the user" do
        post :create, user: Fabricate.attributes_for(:user, username: nil)
        expect(User.count).to eq(0)
      end

      it "assigns an empty @user" do
        post :create, user: Fabricate.attributes_for(:user, username: nil)
        expect(assigns(:user)).to be_a_new(User)
      end
      it "renders the :new page" do
        post :create, user: Fabricate.attributes_for(:user, username: nil)
        expect(response).to render_template :new
      end
    end
  end
end