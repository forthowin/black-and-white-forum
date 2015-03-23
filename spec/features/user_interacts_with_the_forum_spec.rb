require 'rails_helper'

feature "User interacts with the forum" do
  scenario "create and reply to a subject" do
    war = Fabricate(:topic, title: 'war')
    
    login

    click_link war.title
    expect_topic_title_to_be_shown(war.title)

    click_link 'Create Subject'
    expect_subject_page_to_be_shown

    create_a_new_subject
    expect_subject_to_be_shown

    create_a_reply_post('This war is pretty fun')
    expect_post_to_be_shown('This war is pretty fun')
  end

  def create_a_new_subject
    fill_in :title, with: 'Strategy for this war'
    fill_in :body, with: 'Coming soon'
    click_button 'Submit'
  end

  def expect_subject_to_be_shown
    expect(page).to have_content('Strategy for this war')
  end

  def expect_subject_page_to_be_shown
    expect(page).to have_content('Create Subject')
  end

  def expect_topic_title_to_be_shown(title)
    expect(page).to have_content(title)
  end

  def create_a_reply_post(body)
    fill_in :body, with: body
    click_button 'Submit'
  end

  def expect_post_to_be_shown(post)
    expect(page).to have_content(post)
  end

end