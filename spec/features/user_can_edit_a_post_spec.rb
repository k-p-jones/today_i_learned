# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User can edit a post', type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, title: 'Original title.') }

  context 'with no signed in user' do
    it 'redirects to the sign in page' do
      visit edit_post_path(post.id)
      expect(current_path).to eql(user_session_path)
    end
  end

  context 'with a user signed in' do
    before(:each) do
      log_in_with(user.email, user.password)
    end

    context 'with a valid request' do
      it 'edits the post', js: true do
        new_title = 'New title.'
        new_body = 'Some text content'

        visit edit_post_path(post.id)
        expect(page).to have_field('Title', with: 'Original title.')

        fill_in 'Title', with: new_title
        fill_in_trix_editor with: new_body

        click_on 'Update Post'

        expect(current_path).to eql(post_path(post.id))
        expect(page).to have_content(new_title)
        expect(page).to have_content(new_body)
        expect(page).to have_content('Post updated.')
      end
    end

    context 'with an invalid request' do
      it 'displays the validation error', js: true do
        visit edit_post_path(post.id)
        expect(page).to have_field('Title', with: 'Original title.')

        fill_in 'Title', with: ''

        click_on 'Update Post'

        expect(current_path).to eql(post_path(post.id))
        expect(page).to have_content("Title can't be blank")
      end
    end
  end
end
