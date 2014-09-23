FactoryGirl.define do

  factory :user, :class => User do
    id 1
    user_name "tanaka"
    following_users 33
    followers 44
    items 55
    entries {[
       FactoryGirl.create(:entry, :entry_1)
    ]}
  end

  factory :user_yamada, :class => User do
    id 2
    user_name "yamada"
    following_users 5
    followers 4
    items 3
    entries {[
       FactoryGirl.create(:entry, :entry_2)
    ]}
  end

  factory :user_suzuki, :class => User do
    id 3
    user_name "suzuki"
    following_users 50
    followers 0
    items 11
    entries {[
       FactoryGirl.create(:entry, :entry_3)
    ]}
  end

  factory :entry, :class => Entry do

    trait :entry_1 do
      id 1
      title "テストエントリー(2014-09-01 00:00:00)"    
      uuid "aabbccdd"
      stock_count 10
      hatebu_count 20
      comment_count 5
      entry_created "2014-09-01 00:00:00"
      created_at "2014-09-01 00:00:00"
      updated_at "2014-09-01 00:00:00"
      after(:create) do |entry|
        create(:entries_tag, entry: entry, tag: create(:tag, :tag_ruby))
      end
    end

    trait :entry_2 do
      id 2
      title "テストエントリー(2014-09-22 00:00:00)"    
      uuid "aabbccdd"
      stock_count 3
      hatebu_count 33
      comment_count 99
      entry_created "2014-09-22 00:00:00"
      created_at "2014-09-22 00:00:00"
      updated_at "2014-09-22 00:00:00"
      after(:create) do |entry|
        create(:entries_tag, entry: entry, tag: create(:tag, :tag_php))
      end
    end

    trait :entry_3 do
      id 3
      title "テストエントリー(2014-09-10 00:00:00)"    
      uuid "aabbccdd"
      stock_count 15
      hatebu_count 4
      comment_count 1
      entry_created "2014-09-10 00:00:00"
      created_at "2014-09-10 00:00:00"
      updated_at "2014-09-10 00:00:00"
      after(:create) do |entry|
        create(:entries_tag, entry: entry, tag: create(:tag, :tag_php))
        create(:entries_tag, entry: entry, tag: create(:tag, :tag_ruby))
      end
    end

  end

  factory :tag, :class => Tag do
    trait :tag_ruby do
      tag_name "ruby"
    end

    trait :tag_php do
      tag_name "php"
    end
  end

  factory :entries_tag, :class => EntriesTag do
    entry
    tag
  end
end
