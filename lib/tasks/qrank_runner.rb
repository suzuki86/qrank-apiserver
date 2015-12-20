require 'net/http'
require 'activerecord-import'

class QrankRunner
  def self.get_entries(page = 0)
    Entry.get_entries(page)
  end

  def self.update_entry
    Entry.update_entry
  end

  def self.update_user
    Entry.update_user
  end
end
