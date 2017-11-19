require 'spec_helper'
require 'rails_helper'

describe User do
  let!(:user_tanaka) do
    FactoryGirl.create(:user_tanaka)
  end

  let!(:user_yamada) do
    FactoryGirl.create(:user_yamada)
  end

  let!(:user_suzuki) do
    FactoryGirl.create(:user_suzuki)
  end

  describe "#ranking" do
    it "returns array of users that is sorted by like_total in descending order"do
      users = User.ranking("like_total")
      expect(users[0].like_total > users[1].like_total).to be true
      expect(users.first.like_total > users.last.like_total).to be true
    end

    it "returns array of users that is sorted by hatebu_total in descending order"do
      users = User.ranking("hatebu_total")
      expect(users[0].hatebu_total > users[1].hatebu_total).to be true
      expect(users.first.hatebu_total > users.last.hatebu_total).to be true
    end

    it "returns array of users that is sorted by items in descending order"do
      users = User.ranking("users.items")
      expect(users[0].items > users[1].items).to be true
      expect(users.first.items > users.last.items).to be true
    end
  end
end
