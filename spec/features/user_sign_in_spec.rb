require 'rails_helper'

feature "user sign in" do
  scenario "with a valid account" do
    bob = Fabricate(:user, username: 'bob', password: 'password')
    login(bob)
    expect(page).to have_content(bob.username)
  end
end