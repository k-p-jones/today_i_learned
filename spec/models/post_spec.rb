# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:post)).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_rich_text(:body) }
  it { is_expected.to have_many(:tags).through(:taggings) }
  it { is_expected.to have_many(:taggings) }

  context '#formatted_date' do
    it 'formats the date' do
      post = FactoryBot.build(:post, created_at: '10/10/2020')
      expect(post.formatted_date).to eql('October 10, 2020')
    end
  end

  context '.tagged_with(name)' do
    let!(:post_one)   { FactoryBot.create(:post) }
    let!(:post_two)   { FactoryBot.create(:post) }
    let!(:post_three) { FactoryBot.create(:post) }
    let!(:tag)        { FactoryBot.create(:tag) }
    let!(:tagging_one) { FactoryBot.create(:tagging, tag_id: tag.id, post_id: post_one.id) }
    let!(:tagging_two) { FactoryBot.create(:tagging, tag_id: tag.id, post_id: post_two.id) }

    it 'returns the correct posts' do
      expect(Post.tagged_with(tag.name)).to match_array([post_one, post_two])
    end
  end

  context '#tag_list' do
    let!(:post)        { FactoryBot.create(:post) }
    let!(:tag)         { FactoryBot.create(:tag) }
    let!(:tag_two)     { FactoryBot.create(:tag) }
    let!(:tagging_one) { FactoryBot.create(:tagging, tag_id: tag.id, post_id: post.id) }
    let!(:tagging_two) { FactoryBot.create(:tagging, tag_id: tag_two.id, post_id: post.id) }

    it 'returns a list of tags on the post' do
      expect(post.tag_list).to eql("#{tag.name}, #{tag_two.name}")
    end
  end

  context '#tag_list=(names)' do
    let!(:post) { FactoryBot.create(:post) }

    it 'it creates tags and taggings for the post' do
      expect(Tagging.count).to be 0
      expect(Tag.count).to be 0

      post.tag_list = 'css, javascript'

      expect(Tagging.count).to be 2
      expect(Tag.count).to be 2
      expect(post.tags.length).to be 2
    end
  end
end
