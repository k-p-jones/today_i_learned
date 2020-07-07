# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  validates_presence_of :title

  def formatted_date
    created_at.strftime('%B %d, %Y')
  end
end
