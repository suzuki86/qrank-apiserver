# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'
Dir[Rails.root.join('spec/support/factories/*.rb')].each {|f| require f }

FactoryGirl.create(:user_tanaka)
FactoryGirl.create(:user_yamada)
FactoryGirl.create(:user_suzuki)
FactoryGirl.create(:user_takeuchi)

=begin
users = {}
users[:tanaka] = User.create(:user_name => "tanaka", :following_users => 10, :followers => 5, :items => 30)
users[:yamada] = User.create(:user_name => "yamada", :following_users => 13, :followers => 88, :items => 60)
users[:suzuki] = User.create(:user_name => "suzuki", :following_users => 2, :followers => 111, :items => 44)
users[:nishiyama] = User.create(:user_name => "nishiyama", :following_users => 0, :followers => 74, :items => 11)
users[:takeda] = User.create(:user_name => "takeda", :following_users => 33, :followers => 234, :items => 89)
users[:sugawa] = User.create(:user_name => "sugawa", :following_users => 99, :followers => 145, :items => 1)

entry = users[:tanaka].entries.create(
  :title => "テストエントリー(2014-08-15 00:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 10,
  :hatebu_count => 20,
  :entry_created => "2014-08-15 00:00:00"
)
entry.tags.create(:tag_name => "ruby")

entry = users[:yamada].entries.create(
  :title => "テストエントリー(2014-09-01 00:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 5,
  :hatebu_count => 11,
  :entry_created => "2014-09-01 00:00:00"
)
entry.tags.create(:tag_name => "php")

entry = users[:suzuki].entries.create(
  :title => "テストエントリー(2014-09-10 00:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 15,
  :hatebu_count => 33,
  :entry_created => "2014-09-10 00:00:00"
)
entry.tags.create(:tag_name => "テスト")

entry = users[:nishiyama].entries.create(
  :title => "テストエントリー(2014-09-15 00:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 30,
  :hatebu_count => 0,
  :entry_created => "2014-09-15 00:00:00"
)
entry.tags.create(:tag_name => "php")
entry.tags.create(:tag_name => "ruby")

entry = users[:takeda].entries.create(
  :title => "テストエントリー(2014-09-20 00:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 0,
  :hatebu_count => 13,
  :entry_created => "2014-09-20 00:00:00"
)

entry = users[:sugawa].entries.create(
  :title => "テストエントリー(2014-09-21 03:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 3,
  :hatebu_count => 55,
  :entry_created => "2014-09-21 03:00:00"
)

entry = users[:suzuki].entries.create(
  :title => "テストエントリー(2014-09-25 00:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 50,
  :hatebu_count => 999,
  :entry_created => "2014-09-25 00:00:00"
)

entry = users[:nishiyama].entries.create(
  :title => "テストエントリー(2014-09-16 00:00:00)",
  :uuid => "aabbccdd",
  :stock_count => 88,
  :hatebu_count => 111,
  :entry_created => "2014-09-16 00:00:00"
)
=end
