# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign in', type: :feature do
  let(:user)             { create(:user) }
  let(:invalid_email)    { 'invalid@email.com' }
  let(:invalid_password) { 'pa$$word' }

  context 'with a valid user account' do
    it 'logs the user in and goes to the root path' do
      # This should redirect to the posts/dashboard path
      # when those routes are added.
      visit '/users/sign_in'
      expect(page).to have_content('Log in')
      log_in_with(user.email, user.password)
      expect(page).to have_content('Signed in successfully.')
      expect(current_path).to eql(root_path)
    end
  end

  context 'without a valid user account' do
    it 'does not allow sign in' do
      visit '/users/sign_in'
      expect(page).to have_content('Log in')
      log_in_with(invalid_email, invalid_password)
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
