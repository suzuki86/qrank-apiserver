class User < ActiveRecord::Base
  paginates_per 20
  has_many :entries
  accepts_nested_attributes_for :entries
end
