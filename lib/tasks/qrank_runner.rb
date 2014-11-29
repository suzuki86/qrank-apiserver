require 'pp'
require 'net/http'
require 'activerecord-import'

class QrankRunner

  def self.get_entries
    Entry.get_entries
  end

  def self.update_entry
    Entry.update_entry
  end

  def self.update_user
    Entry.update_user
  end

end
