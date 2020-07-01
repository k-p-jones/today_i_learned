# frozen_string_literal: true

module FormHelpers
  def log_in_with(email, password)
    within('#new_user') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
    end
    click_button 'Log in'
  end
end

RSpec.configure do |config|
  config.include FormHelpers, type: :feature
end
