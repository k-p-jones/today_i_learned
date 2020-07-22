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
    before(:each) do
      log_in_with(user.email, user.password)
    end

    context 'with a valid post' do
      it 'lets a user view the dashboard', js: true do
        title = 'This is a Post'
        body = 'Here is some content for your post'

        click_on 'New Post'
        expect(current_path).to eql(new_post_path)

        expect(Post.count).to eql(0)
        expect(Tag.count).to eql(0)
        expect(Tagging.count).to eql(0)

        fill_in 'Title', with: title
        fill_in 'Tag list', with: 'css, javascript'
        fill_in_trix_editor with: body

        click_on 'Create Post'

        expect(Post.count).to eql(1)
        expect(Tag.count).to eql(2)
        expect(Tagging.count).to eql(2)
        expect(current_path).to eql(post_path(Post.last.id))
        expect(page).to have_content('New post created.')
        expect(page).to have_content(title)
        expect(page).to have_content(body)
        expect(page).to have_content('#css')
        expect(page).to have_content('#javascript')
        expect(page).to have_link('#css', href: root_path(tag: 'css'))
        expect(page).to have_link('#javascript', href: root_path(tag: 'javascript'))
      end
    end

    context 'with an invalid post' do
      it 'displays the validation error' do
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
