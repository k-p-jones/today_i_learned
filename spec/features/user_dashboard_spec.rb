# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  context 'with no signed in user' do
    it 'redirects to the sign in page' do
      visit user_root_path
      expect(current_path).to eql(user_session_path)
    end
  end
end
