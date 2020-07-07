# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:post)).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_rich_text(:body) }

  context '#formatted_date' do
    it 'formats the date' do
      post = FactoryBot.build(:post, created_at: '10/10/2020')
      expect(post.formatted_date).to eql('October 10, 2020')
    end
  end
end
