class User < ActiveRecord::Base
  paginates_per 20
  has_many :entries
  accepts_nested_attributes_for :entries

  scope :ranking_by, ->(ranking) { order(ranking + " DESC") }
end
