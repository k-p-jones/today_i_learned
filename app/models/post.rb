# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  validates_presence_of :title
end
