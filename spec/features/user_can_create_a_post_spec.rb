# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User can create a post', type: :feature do
  let!(:user) { FactoryBot.create(:user) }

  context 'with no signed in user' do
    it 'redirects to the sign in page' do
      visit new_post_path
      expect(current_path).to eql(user_session_path)
    end
  end

  context 'with a user signed in' do
    context 'with a valid post' do
      it 'lets a user view the dashboard', js: true do
        log_in_with(user.email, user.password)

        click_on 'New Post'
        expect(current_path).to eql(new_post_path)

        expect(Post.count).to eql(0)

        fill_in 'Title', with: 'This is a Post'
        fill_in_trix_editor with: '<em>Oh Lordy</em>'

        click_on 'Create Post'

        expect(page).to have_content('New post created.')
        expect(current_path).to eql(user_root_path)
        expect(Post.count).to eql(1)
      end
    end

    context 'with an invalid post' do
      it 'displays the validation error' do
        log_in_with(user.email, user.password)

        click_on 'New Post'
        expect(current_path).to eql(new_post_path)

        expect(Post.count).to eql(0)

        click_on 'Create Post'

        expect(page).to have_content("Title can't be blank")
        expect(current_path).to eql(posts_path)
        expect(Post.count).to eql(0)
      end
    end
  end
end
