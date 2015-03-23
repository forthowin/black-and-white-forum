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
        post :create, title: 'title', body: 'body', topic_id: topic.id
      end

      it "creates a subject" do
        expect(Subject.count).to eq(1)
      end

      it "creates a post" do
        expect(Post.count).to eq(1)
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
        request.env["HTTP_REFERER"] = "/forum/#{topic.id}/new"
      end

      it "redirects back to the new page" do
        post :create, title: '', body: 'body', topic_id: topic.id
        expect(response).to redirect_to new_subject_path(topic.id)
      end

      it "does not create a subject when the title is blank" do
        post :create, title: '', body: 'body', topic_id: topic.id
        expect(Subject.count).to eq(0)
      end

      it "does not create a subject when the body is blank" do
        post :create, title: 'title', body: '', topic_id: topic.id
        expect(Subject.count).to eq(0)
      end

      it "does not create a post when the title is blank" do
        post :create, title: '', body: 'body', topic_id: topic.id
        expect(Post.count).to eq(0)
      end

      it "does not create a post when the body is blank" do
        post :create, title: 'title', body: '', topic_id: topic.id
        expect(Post.count).to eq(0)
      end

      it "sets the flash danger message" do
        post :create, title: '', body: 'body', topic_id: topic.id
        expect(flash[:danger]).to be_present
      end
    end

    it "redirects to login page for unauthenticated users" do
      post :create, subject: {title: 'test', body: 'asdf'}, topic_id: topic.id
      expect(response).to redirect_to login_path
    end
  end
end