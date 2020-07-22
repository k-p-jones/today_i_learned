# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings

  before_save :sanitise_name!

  validates_presence_of :name
  validates_uniqueness_of :name

  private

  def sanitise_name!
    return unless name

    self.name = name.downcase.strip
  end
end
