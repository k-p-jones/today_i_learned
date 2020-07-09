# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home page', type: :feature do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:post_1) { FactoryBot.create(:post, user_id: user_1.id) }
  let!(:user_2) { FactoryBot.create(:user) }
  let!(:post_2) { FactoryBot.create(:post, user_id: user_2.id) }

  it 'displays all the posts' do
    visit root_path
    expect(page).to have_content(post_1.title)
    expect(page).to have_content(post_1.formatted_date)
    expect(page).to have_content(post_2.title)
    expect(page).to have_content(post_2.formatted_date)
    expect(page).to have_link('View', href: post_path(post_1.id))
    expect(page).to have_link('View', href: post_path(post_2.id))
  end
end
