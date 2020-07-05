# frozen_string_literal: true

module FormHelpers
  def log_in_with(email, password)
    visit user_session_path
    within('#new_user') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
    end
    click_button 'Log In'
  end

  def fill_in_trix_editor(with:)
    find('trix-editor').click.set(with)
  end
end

RSpec.configure do |config|
  config.include FormHelpers, type: :feature
end
