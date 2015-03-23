require "rails_helper"

describe UsersController do
  describe "GET new" do
    it "assigns @user as a new User" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "redirects to the forum path for users that is already logged in" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      get :new
      expect(response).to redirect_to forum_path
    end
  end

  describe "POST create" do
    context "with valid input" do
      before{ post :create, user: Fabricate.attributes_for(:user) }
      
      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end

      it "saves the user into the session" do
        expect(session[:user_id]).to be_present
      end

      it "redirects to the forum page" do
        expect(response).to redirect_to forum_path
      end
    end

    context "with invalid input" do
      before { post :create, user: Fabricate.attributes_for(:user, username: nil) }
      
      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "assigns an empty @user" do
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders the :new page" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    let(:bob) { Fabricate(:user) }
    it "assigns @user" do
      session[:user_id] = bob.id
      get :show, id: bob.id
      expect(assigns(:user)).to eq(bob)
    end

    it "redirects to the login page for unauthenticated users" do
      get :show, id: bob.id
      expect(response).to redirect_to login_path
    end
  end
end