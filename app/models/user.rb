class User < ActiveRecord::Base
  paginates_per 20
  has_many :entries
  accepts_nested_attributes_for :entries

  scope :ranking_by, ->(ranking) { order(ranking + " DESC") }

  def self.ranking(key)
    joins(:entries)
    .select("
      users.id,
      users.user_name,
      sum(entries.stock_count) AS stock_total,
      sum(entries.hatebu_count) AS hatebu_total,
      users.items
    ")
    .group(:id)
    .ranking_by(key)
    .limit(100)
  end
end
