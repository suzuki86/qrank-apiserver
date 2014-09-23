class Entry < ActiveRecord::Base
  paginates_per 20
  has_many :entries_tags
  has_many :tags, through: :entries_tags
  belongs_to :user
  accepts_nested_attributes_for :tags
end
