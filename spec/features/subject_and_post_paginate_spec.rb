require 'rails_helper'

feature "User can paginate subject and post pages" do
  context "subject index page" do
    background do
      bob = Fabricate(:user)
      war = Fabricate(:topic)
      @other_war = Fabricate(:subject, user: bob, topic: war)
      post1 = Fabricate(:post, user: bob, subject: @other_war)
      9.times do
        Fabricate(:post, user: bob, subject: Fabricate(:subject, user: bob, topic: war))
      end
      @current_war = Fabricate(:subject, user: bob, topic: war)
      post2 = Fabricate(:post, user: bob, subject: @current_war)
    end

    scenario "click next to view next 10 subjects" do
      login

      click_link Topic.first.title
      expect_content_to_be_shown(@current_war.title)

      click_next_link_on_subject_index
      expect_content_to_be_shown(@other_war.title)
    end
  end

  context "subject show page" do
    background do
      bob = Fabricate(:user)
      war = Fabricate(:topic)
      current_war = Fabricate(:subject, user: bob, topic: war)
      @first_post = Fabricate(:post, user: bob, subject: current_war)
      Fabricate.times(9, :post, user: bob, subject: current_war)
      @last_post = Fabricate(:post, user: bob, subject: current_war)
    end

    scenario "click next to view next 10 posts" do
      login

      click_link Topic.first.title

      click_link Subject.first.title
      expect_content_to_be_shown(@first_post.body)

      click_next_link_on_subject_show
      expect_content_to_be_shown(@last_post.body)
    end
  end

  def click_next_link_on_subject_index
    find("#main > div > div > div > div:nth-child(4) > ul > li.next.next_page > a").click
  end

  def click_next_link_on_subject_show
    find("#main > div > div > div > div:nth-child(2) > ul > li.next.next_page > a").click
  end

  def expect_content_to_be_shown(content)
    expect(page).to have_content(content)
  end
end