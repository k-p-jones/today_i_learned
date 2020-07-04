# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign in', type: :feature do
  let(:user)             { create(:user) }
  let(:invalid_email)    { 'invalid@email.com' }
  let(:invalid_password) { 'pa$$word' }

  context 'with a valid user account' do
    it 'logs the user in and enables them to log out' do
      # This should redirect to the posts/dashboard path
      # when those routes are added.
      visit '/users/sign_in'
      expect(page).to have_selector(:link_or_button, 'Log In')
      log_in_with(user.email, user.password)
      expect(page).to have_content('Signed in successfully.')
      expect(current_path).to eql(root_path)
      expect(page).to have_selector(:link_or_button, 'Log Out')

      click_link 'Log Out'
      expect(page).to have_content('Signed out successfully.')
    end
  end

  context 'without a valid user account' do
    it 'does not allow sign in' do
      visit '/users/sign_in'
      expect(page).to have_selector(:link_or_button, 'Log In')
      log_in_with(invalid_email, invalid_password)
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
