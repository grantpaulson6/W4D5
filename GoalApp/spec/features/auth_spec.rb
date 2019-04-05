require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do

    subject(:user_attr) { FactoryBot.build(:user) }
    background(:each) do #similar to before
        visit new_user_path 
        fill_in("Username:", with: user_attr.username)
        fill_in("Password:", with: "football")
    end

  scenario 'has a new user page' do
    expect(page).to have_content("Sign Up")
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
        #fill in 
        click_button("Sign Up")  
        user = User.find_by(username: user_attr.username)
        expect(user).not_to be_nil
        expect(current_path).to eq(user_path(user))
        expect(page).to have_content(user.username)
    end

  end
end

feature 'logging in' do
    
    subject(:user_attr) { FactoryBot.create(:user) }
    background(:each) do #similar to before
        visit new_session_path 
        fill_in("Username:", with: user_attr.username)
        fill_in("Password:", with: "football")
    end

  scenario 'shows username on the homepage after login' do
    click_button("Log In")  
    user = User.find_by(username: user_attr.username)
    expect(page).to have_content(user.username)
  end
end

feature 'logging out' do

    subject(:user_attr) { FactoryBot.create(:user) }

    background(:each) do 
        visit new_session_path 
        fill_in("Username:", with: user_attr.username)
        fill_in("Password:", with: "football")
        click_button("Log In")  
        click_button("Log Out")

    end

  scenario 'doesn\'t show username on the homepage after logout' do
    user = User.find_by(username: user_attr.username)
    expect(page).to_not have_content(user.username)
  end

end