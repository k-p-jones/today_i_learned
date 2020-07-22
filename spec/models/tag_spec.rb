# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:tag)).to be_valid
  end

  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:taggings) }
  it { is_expected.to have_many(:posts).through(:taggings) }
end
