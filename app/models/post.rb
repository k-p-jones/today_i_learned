# frozen_string_literal: true

class Post < ApplicationRecord
  self.per_page = 8

  has_rich_text :body
  validates_presence_of :title

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  def formatted_date
    created_at.strftime('%B %d, %Y')
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.find_or_create_by(name: name.downcase.strip)
    end
  end
end
