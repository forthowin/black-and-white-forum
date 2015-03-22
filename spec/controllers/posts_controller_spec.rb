require 'rails_helper'

describe PostsController do
  describe "POST create" do
    let(:bob) { Fabricate:user }
    let(:topic1) { Fabricate(:topic) }
    let(:subject1) { Fabricate(:subject, user: bob, topic: topic1) }

    before do
      request.env["HTTP_REFERER"] = "/forum/#{topic1.id}/subject/#{subject1.id}"
    end

    context "with valid inputs" do
      it "creates a new post" do
        session[:user_id] = bob.id
        post :create, body: 'test', subject_id: subject1.id
        expect(Post.count).to eq(1)
      end

      it "redirects to the same subject" do
        session[:user_id] = bob.id
        post :create, body: 'test', subject_id: subject1.id
        expect(response).to redirect_to forum_subject_path(topic1.id, subject1.id)
      end

      it "sets the flash success message" do
        session[:user_id] = bob.id
        post :create, body: 'test', subject_id: subject1.id
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      it "does not create a post" do
        session[:user_id] = bob.id
        post :create, body: nil, subject_id: subject1.id
        expect(Post.count).to eq(0)
      end

      it "redirects to the same subject" do
        session[:user_id] = bob.id
        post :create, body: nil, subject_id: subject1.id
        expect(response).to redirect_to forum_subject_path(topic1.id, subject1.id) 
      end

      it "sets the flash danger message" do
        session[:user_id] = bob.id
        post :create, body: nil, subject_id: subject1.id
        expect(flash[:danger]).to be_present
      end
    end

    context "with an unauthorized user" do
      it "redirects to the login path" do
        post :create, body: 'test', subject_id: subject1.id
        expect(response).to redirect_to login_path
      end
    end
  end
end