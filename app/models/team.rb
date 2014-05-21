class Team < ActiveRecord::Base
  has_many :users

  attr_accessible :name, :user_ids
  accepts_nested_attributes_for :users
end
