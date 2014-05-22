class Team < ActiveRecord::Base
  has_many :users

  validates :name, presence: true, uniqueness: true

  attr_accessible :name, :user_ids
  accepts_nested_attributes_for :users
end
