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
    context 'without paginated results' do
      let!(:post) { FactoryBot.create(:post, user_id: user.id) }

      it 'lets a user view the dashboard' do
        log_in_with(user.email, user.password)
        expect(current_path).to eql(user_root_path)
        expect(page).to have_link(post.title, href: post_path(post.id))
        expect(page).to have_content(post.formatted_date)
        expect(page).to have_link('View', href: post_path(post.id))
        expect(page).to have_link('Edit', href: edit_post_path(post.id))
        expect(page).to have_link('Destroy', href: post_path(post.id))
      end
    end

    context 'with paginated results' do
      let!(:post_1)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 10) }
      let!(:post_2)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 9) }
      let!(:post_3)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 8) }
      let!(:post_4)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 7) }
      let!(:post_5)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 6) }
      let!(:post_6)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 5) }
      let!(:post_7)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 4) }
      let!(:post_8)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 3) }
      let!(:post_9)  { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 2) }
      let!(:post_10) { FactoryBot.create(:post, user_id: user.id, created_at: Date.today - 1) }
      let!(:post_11) { FactoryBot.create(:post, user_id: user.id, created_at: Date.today) }

      it 'correctly paginates the posts' do
        log_in_with(user.email, user.password)
        expect(page).to have_content('Displaying Post 1 - 8 of 11 in total')
        expect(page).to have_link(post_11.title, href: post_path(post_11.id))
        expect(page).to have_content(post_11.formatted_date)
        expect(page).to have_link('View', href: post_path(post_11.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_11.id))
        expect(page).to have_link('Destroy', href: post_path(post_11.id))
        expect(page).to have_link(post_10.title, href: post_path(post_10.id))
        expect(page).to have_content(post_10.formatted_date)
        expect(page).to have_link('View', href: post_path(post_10.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_10.id))
        expect(page).to have_link('Destroy', href: post_path(post_10.id))
        expect(page).to have_link(post_9.title, href: post_path(post_9.id))
        expect(page).to have_content(post_9.formatted_date)
        expect(page).to have_link('View', href: post_path(post_9.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_9.id))
        expect(page).to have_link('Destroy', href: post_path(post_9.id))
        expect(page).to have_link(post_8.title, href: post_path(post_8.id))
        expect(page).to have_content(post_8.formatted_date)
        expect(page).to have_link('View', href: post_path(post_8.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_8.id))
        expect(page).to have_link('Destroy', href: post_path(post_8.id))
        expect(page).to have_link(post_7.title, href: post_path(post_7.id))
        expect(page).to have_content(post_7.formatted_date)
        expect(page).to have_link('View', href: post_path(post_7.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_7.id))
        expect(page).to have_link('Destroy', href: post_path(post_7.id))
        expect(page).to have_link(post_6.title, href: post_path(post_6.id))
        expect(page).to have_content(post_6.formatted_date)
        expect(page).to have_link('View', href: post_path(post_6.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_6.id))
        expect(page).to have_link('Destroy', href: post_path(post_6.id))
        expect(page).to have_link(post_5.title, href: post_path(post_5.id))
        expect(page).to have_content(post_5.formatted_date)
        expect(page).to have_link('View', href: post_path(post_5.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_5.id))
        expect(page).to have_link('Destroy', href: post_path(post_5.id))
        expect(page).to have_link(post_4.title, href: post_path(post_4.id))
        expect(page).to have_content(post_4.formatted_date)
        expect(page).to have_link('View', href: post_path(post_4.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_4.id))
        expect(page).to have_link('Destroy', href: post_path(post_4.id))

        click_link '>'
        expect(page).to have_content('Displaying Post 9 - 11 of 11 in total')
        expect(page).to have_link(post_3.title, href: post_path(post_3.id))
        expect(page).to have_content(post_3.formatted_date)
        expect(page).to have_link('View', href: post_path(post_3.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_3.id))
        expect(page).to have_link('Destroy', href: post_path(post_3.id))
        expect(page).to have_link(post_2.title, href: post_path(post_2.id))
        expect(page).to have_content(post_2.formatted_date)
        expect(page).to have_link('View', href: post_path(post_2.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_2.id))
        expect(page).to have_link('Destroy', href: post_path(post_2.id))
        expect(page).to have_link(post_1.title, href: post_path(post_1.id))
        expect(page).to have_content(post_1.formatted_date)
        expect(page).to have_link('View', href: post_path(post_1.id))
        expect(page).to have_link('Edit', href: edit_post_path(post_1.id))
        expect(page).to have_link('Destroy', href: post_path(post_1.id))
      end
    end
  end
end
