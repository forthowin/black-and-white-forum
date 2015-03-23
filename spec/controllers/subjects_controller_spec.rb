require 'rails_helper'

describe SubjectsController do
  describe "GET index" do
    let(:bob) { Fabricate(:user) }
    let(:topic) { Fabricate(:topic) }

    it "assigns @subjects" do
      session[:user_id] = bob.id
      subject1 = Fabricate(:subject, user: bob, topic: topic)
      subject2 = Fabricate(:subject, user: bob, topic: topic)
      get :index, topic_id: topic.id
      expect(assigns(:subjects)).to match_array([subject1, subject2])
    end

    it "redirects to the login page for unauthenticated users" do
      get :index, topic_id: topic.id
      expect(response).to redirect_to login_path
    end
  end

  describe "GET show" do
    let(:bob) { Fabricate(:user) }
    let(:topic) { Fabricate(:topic) }
    let(:subject) { Fabricate(:subject, user: bob, topic: topic) }
    
    it "assigns @subject" do
      session[:user_id] = bob.id
      get :show, topic_id: topic.id, subject_id: subject.id
      expect(assigns(:subject)).to eq(subject)
    end

    it "assigns @topic" do
      session[:user_id] = bob.id
      get :show, topic_id: topic.id, subject_id: subject.id
      expect(assigns(:topic)).to eq(topic)
    end

    it "redirects to the login page for unauthenticated users" do
      get :show, topic_id: topic.id, subject_id: subject.id
      expect(response).to redirect_to login_path
    end
  end

  describe "GET new" do
    let(:bob) { Fabricate(:user) }
    let(:topic) { Fabricate(:topic) }

    it "assigns @subject" do
      session[:user_id] = bob.id
      get :new, topic_id: topic.id 
      expect(assigns(:subject)).to be_a_new(Subject)
    end

    it "assigns @topic" do
      session[:user_id] = bob.id
      get :new, topic_id: topic.id 
      expect(assigns(:topic)).to eq(topic)
    end

    it "redirects to login page for unauthenticated users" do
      get :new, topic_id: topic.id 
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    let(:bob) { Fabricate(:user) }
    let(:topic) { Fabricate(:topic) }

    context "with valid inputs" do
      before do
        session[:user_id] = bob.id
        post :create, subject: {title: 'title', body: 'body'}, topic_id: topic.id
      end

      it "creates a new subject" do
        expect(Subject.count).to eq(1)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to the show subject path" do
        expect(response).to redirect_to forum_subject_path(topic.id, 1)
      end
    end

    context "with invalid inputs" do
      before do
        session[:user_id] = bob.id
        post :create, subject: {title: '', body: 'body'}, topic_id: topic.id
      end
      it "renders the :new page" do
        expect(response).to render_template :new
      end

      it "does not create a subject" do
        expect(Subject.count).to eq(0)
      end

      it "assigns @subject" do
        expect(assigns(:subject)).to be_a_new(Subject)
      end

      it "assigns @topic" do
        expect(assigns(:topic)).to eq(topic)
      end
    end

    it "redirects to login page for unauthenticated users" do
      post :create, subject: {title: 'test', body: 'asdf'}, topic_id: topic.id
      expect(response).to redirect_to login_path
    end
  end
end