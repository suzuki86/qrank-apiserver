require 'net/http'
require 'activerecord-import'

class Entry < ActiveRecord::Base
  paginates_per 20
  has_many :entries_tags
  has_many :tags, through: :entries_tags
  belongs_to :user
  accepts_nested_attributes_for :tags

  def self.get_entries(page)
    endpoint = "https://qiita.com/api/v2/items?per_page=100"

    if page then
      endpoint = endpoint + "&page=" + page.to_s
    end

    url = URI.parse(endpoint)
    http = Net::HTTP.new(url.host, url.port);
    http.use_ssl = true
    headers = {
      "User-Agent" => "qrank",
      "Authorization" => "Bearer " + Rails.application.secrets.qiita_api_key
    }
    response = http.get(endpoint, headers)

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    tags = entries = users = []
    parsed_response.each do |entry|
      entry_url = entry[:url].gsub(/http:/, "https:")
      hatebu = self.get_hatebu(entry_url)
      saved_entry = Entry.find_by(:uuid => entry[:id])

      if saved_entry then
        data = {
          :title => entry[:title],
          :url => entry[:url],
          :user_id => entry[:user][:permanent_id],
          :like_count => entry[:likes_count] || 0,
          :comment_count => entry[:comment_count] || 0,
          :hatebu_count => hatebu
        }
        Entry.update(saved_entry[:id], data)
      else
        current_entry = Entry.new(
          :title => entry[:title],
          :uuid => entry[:id],
          :url => entry[:url],
          :user_id => entry[:user][:permanent_id],
          :like_count => entry[:likes_count] || 0,
          :comment_count => entry[:comments_count] || 0,
          :hatebu_count => hatebu,
          :entry_created => Time.parse(entry[:created_at])
        )
        current_entry.save

        entry[:tags].each do |tag|
          current_entry.tags.create(
            :tag_name => tag[:name]
          )
        end
        users << User.new(
          :id => entry[:user][:permanent_id],
          :user_name => entry[:user][:id],
          :following_users => entry[:user][:followees_count],
          :followers => entry[:user][:followers_count],
          :items => entry[:user][:items_count],
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

  def self.get_oldest_entry
    Entry.order(:updated_at).first
  end

  def self.update_entry
    entry = get_oldest_entry
    endpoint = "https://qiita.com/api/v2/items/" + entry.uuid
    url = URI.parse(endpoint)
    response = Net::HTTP.get_response(url)
    if response.code == 200
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      entry.update(
        :uuid => parsed_response[:id],
        :title => entry[:title],
        :url => entry[:url],
        :like_count => entry[:likes_count] || 0,
        :comment_count => entry[:comment_count] || 0,
        :hatebu_count => hatebu
      )
    else
      entry.update(
        :updated_at => Time.now
      )
    end
  end

  def self.get_oldest_user
    User.order(:updated_at).first
  end

  def self.update_user
    user = get_oldest_user
    endpoint = "https://qiita.com/api/v2/users/" + user.user_name
    url = URI.parse(endpoint)
    response = Net::HTTP.get(url)
    parsed_response = JSON.parse(response, symbolize_names: true)
    user.touch
    user.update(
      :id => parsed_response[:id],
      :following_users => parsed_response[:followers_count] || 0,
      :followers => parsed_response[:followees_count] || 0,
      :items => parsed_response[:items_count] || 0
    )
  end

end
