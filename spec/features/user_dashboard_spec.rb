# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  let!(:user) { FactoryBot.create(:user) }

  context 'with no signed in user' do
    it 'redirects to the sign in page' do
      visit user_root_path
      expect(current_path).to eql(user_session_path)
    end
  end

  context 'with a user signed in' do
    it 'lets a user view the dashboard' do
      log_in_with(user.email, user.password)
      expect(current_path).to eql(user_root_path)
    end
  end
end
