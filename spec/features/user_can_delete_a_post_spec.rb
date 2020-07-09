# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User can delete a post', type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user_id: user.id) }

  before(:each) do
    log_in_with(user.email, user.password)
  end

  it 'deletes the post' do
    expect(page).to have_content(post.title)
    expect(Post.count).to eql(1)

    click_link 'Destroy'

    expect(current_path).to eql(user_root_path)
    expect(Post.count).to eql(0)
    expect(page).to_not have_content(post.title)
    expect(page).to have_content('Post deleted.')
  end

  context 'with a failing request' do
    before(:each) do
      allow_any_instance_of(Post).to receive(:destroy).and_return(false)
    end

    it 'displays the error' do
      expect(page).to have_content(post.title)
      expect(Post.count).to eql(1)

      click_link 'Destroy'

      expect(current_path).to eql(user_root_path)
      expect(Post.count).to eql(1)
      expect(page).to have_content(post.title)
      expect(page).to have_content('There was a problem deleting your post.')
    end
  end
end
