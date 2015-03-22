require 'rails_helper'

describe PostsController do
  describe "POST create" do
    let(:bob) { Fabricate:user }
    let(:topic1) { Fabricate(:topic) }
    let(:thread1) { Fabricate(:subject, user: bob, topic: topic1) }

    before do
      request.env["HTTP_REFERER"] = "/forum/#{topic1.id}/thread/#{thread1.id}"
    end

    context "with valid inputs" do
      it "creates a new post" do
        session[:user_id] = bob.id
        post :create, body: 'test', thread_id: thread1.id
        expect(Post.count).to eq(1)
      end

      it "redirects to the same thread" do
        session[:user_id] = bob.id
        post :create, body: 'test', thread_id: thread1.id
        expect(response).to redirect_to forum_thread_path(topic1.id, thread1.id)
      end

      it "sets the flash success message" do
        session[:user_id] = bob.id
        post :create, body: 'test', thread_id: thread1.id
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      it "does not create a post" do
        session[:user_id] = bob.id
        post :create, body: nil, thread_id: thread1.id
        expect(Post.count).to eq(0)
      end

      it "redirects to the same thread" do
        session[:user_id] = bob.id
        post :create, body: nil, thread_id: thread1.id
        expect(response).to redirect_to forum_thread_path(topic1.id, thread1.id) 
      end

      it "sets the flash danger message" do
        session[:user_id] = bob.id
        post :create, body: nil, thread_id: thread1.id
        expect(flash[:danger]).to be_present
      end
    end

    context "with an unauthorized user" do
      it "redirects to the login path" do
        post :create, body: 'test', thread_id: thread1.id
        expect(response).to redirect_to login_path
      end
    end
  end
end