require 'rails_helper'

describe ThreadsController do
  describe "GET index" do
    it "assigns @threads" do
      bob = Fabricate(:user)
      topic = Fabricate(:topic)
      thread1 = Fabricate(:subject, user: bob, topic: topic)
      thread2 = Fabricate(:subject, user: bob, topic: topic)
      get :index, topic_id: topic.id
      expect(assigns(:threads)).to match_array([thread1, thread2])
    end
  end

  describe "GET show" do
    it "assigns @thread" do
      bob = Fabricate(:user)
      topic = Fabricate(:topic)
      thread1 = Fabricate(:subject, user: bob, topic: topic)
      get :show, topic_id: topic.id, thread_id: thread1.id
      expect(assigns(:thread)).to eq(thread1)
    end

    it "assigns @topic" do
      bob = Fabricate(:user)
      topic = Fabricate(:topic)
      thread1 = Fabricate(:subject, user: bob, topic: topic)
      get :show, topic_id: topic.id, thread_id: thread1.id
      expect(assigns(:topic)).to eq(topic)
    end
  end

  describe "GET new" do
    it "assigns @subject" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      topic = Fabricate(:topic)
      get :new, topic_id: topic.id
      expect(assigns(:subject)).to be_a_new(Subject)
    end

    it "assigns @topic" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      topic = Fabricate(:topic)
      get :new, topic_id: topic.id
      expect(assigns(:topic)).to eq(topic)
    end

    it "redirects to login page for unauthenticated users" do
      topic = Fabricate(:topic)
      get :new, topic_id: topic.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      it "redirects to login page for unauthenticated users" do
        topic = Fabricate(:topic)
        bob = Fabricate(:user)
        post :create, subject: {title: 'test', body: 'asdf'}, topic_id: topic.id
        expect(response).to redirect_to login_path
      end

      it "creates a new subject" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        topic = Fabricate(:topic)
        post :create, subject: {title: 'title', body: 'body'}, topic_id: topic.id
        expect(Subject.count).to eq(1)
      end

      it "sets the flash success message" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        topic = Fabricate(:topic)
        post :create, subject: {title: 'title', body: 'body'}, topic_id: topic.id
        expect(flash[:success]).to be_present
      end

      it "redirects to the show subject path" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        topic = Fabricate(:topic)
        post :create, subject: {title: 'title', body: 'body'}, topic_id: topic.id
        expect(response).to redirect_to forum_thread_path(topic.id, 1)
      end
    end

    context "with invalid inputs" do
      it "renders the :new page" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        topic = Fabricate(:topic)
        post :create, subject: {title: '', body: 'body'}, topic_id: topic.id
        expect(response).to render_template :new
      end

      it "does not create a subject" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        topic = Fabricate(:topic)
        post :create, subject: {title: '', body: 'body'}, topic_id: topic.id
        expect(Subject.count).to eq(0)
      end

      it "assigns @subject" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        topic = Fabricate(:topic)
        post :create, subject: {title: '', body: 'body'}, topic_id: topic.id
        expect(assigns(:subject)).to be_a_new(Subject)
      end

      it "assigns @topic" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        topic = Fabricate(:topic)
        post :create, subject: {title: '', body: 'body'}, topic_id: topic.id
        expect(assigns(:topic)).to eq(topic)
      end
    end
  end
end