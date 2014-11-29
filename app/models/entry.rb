require 'net/http'
require 'activerecord-import'

class Entry < ActiveRecord::Base
  paginates_per 20
  has_many :entries_tags
  has_many :tags, through: :entries_tags
  belongs_to :user
  accepts_nested_attributes_for :tags

  def self.get_entries
    endpoint = "https://qiita.com/api/v1/items"
    url = URI.parse(endpoint)
    response = Net::HTTP.get_response(url)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    tags = []
    entries = []
    users = []
    parsed_response.each do |entry|
      entry_url = "http://qiita.com/" + entry[:user][:url_name] + "/items/" + entry[:uuid]
      hatebu = self.get_hatebu(entry_url)

      if Entry.find_by(:id => entry[:id]) then
        entry.update(
          :id => entry[:id],
          :title => entry[:title],
          :user_id => entry[:user][:id],
          :stock_count => entry[:stock_count] || 0,
          :comment_count => entry[:comment_count] || 0,
          :hatebu_count => hatebu,
        )

      else
        current_entry = Entry.new(
          :id => entry[:id],
          :title => entry[:title],
          :uuid => entry[:uuid],
          :user_id => entry[:user][:id],
          :stock_count => entry[:stock_count] || 0,
          :comment_count => entry[:comment_count] || 0,
          :hatebu_count => hatebu,
          :entry_created => Time.parse(entry[:created_at])
        )
        current_entry.save

        entry[:tags].each do |tag|
          current_entry.tags.create(
            :tag_name => tag[:url_name]
          )
        end
        users << User.new(
          :id => entry[:user][:id],
          :user_name => entry[:user][:url_name]
        )
      end
    end
    User.import(
      users,
      {:on_duplicate_key_update => [:user_name]}
    )
  end

  def self.get_hatebu(url)
    endpoint = "http://api.b.st-hatena.com/entry.count?url=" + url
    url = URI.parse(endpoint)
    result = Net::HTTP.get(url)
    if result.empty? then
      response = 0
    else
      response = result
    end
  end

  def self.update_entry
    entry = Entry.order(:updated_at).first
    endpoint = "https://qiita.com/api/v1/items/" + entry.uuid
    url = URI.parse(endpoint)
    response = Net::HTTP.get_response(url)
    if response.code == 200
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      entry.update(
        :id => parsed_response[:id],
        :title => entry[:title],
        :stock_count => entry[:stock_count] || 0,
        :comment_count => entry[:comment_count] || 0,
        :hatebu_count => hatebu
      )
    else
      entry.update(
        :updated_at => Time.now
      )
    end
  end

  def self.update_user
    user = User.order(:updated_at).first
    endpoint = "https://qiita.com/api/v1/users/" + user.user_name
    url = URI.parse(endpoint)
    response = Net::HTTP.get(url)
    parsed_response = JSON.parse(response, symbolize_names: true)
    user.update(
      :id => parsed_response[:id],
      :following_users => parsed_response[:following_users],
      :followers => parsed_response[:followers],
      :items => parsed_response[:items]
    )
  end

end
