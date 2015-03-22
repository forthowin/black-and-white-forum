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
end