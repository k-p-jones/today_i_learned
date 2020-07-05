# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :password

  has_many :posts
end
