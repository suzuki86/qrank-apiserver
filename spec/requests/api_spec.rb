require 'rails_helper'
require 'json_expressions/rspec'

describe API do
  describe "GET /api/v1/entries" do
    it "shows expected entries" do
      FactoryGirl.create(:user_tanaka)
      FactoryGirl.create(:user_yamada)
      FactoryGirl.create(:user_suzuki)
      pattern = [
        {
          id: 3,
          user_id: 3,
          title: "テストエントリー(2014-09-10 00:00:00)",
          uuid: "aabbccdd",
          stock_count: 15,
          comment_count: 1,
          hatebu_count: 4,
          entry_created: "2014-09-10T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "php"
            },
            {
              id: Fixnum,
              tag_name: "ruby"
            }
          ]
        },
        {
          id: 2,
          user_id: 2,
          title: "テストエントリー(2014-09-22 00:00:00)",
          uuid: "aabbccdd",
          stock_count: 3,
          comment_count: 99,
          hatebu_count: 33,
          entry_created: "2014-09-22T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "php"
            }
          ]
        },
        {
          id: 1,
          title: "テストエントリー(2014-09-01 00:00:00)",
          user_id: 1,
          uuid: "aabbccdd",
          stock_count: 10,
          hatebu_count: 20,
          comment_count: 5,
          entry_created: "2014-09-01T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "ruby"
            }
          ]
        }
      ].ordered!
      get "/api/v1/entries"
      expect(response.status).to eq(200)
      expect(response.body).to match_json_expression(pattern)
    end
  end

  describe "GET /api/v1/entries?tag=php" do
    it "shows expected entries filtered by php" do
      FactoryGirl.create(:user_tanaka)
      FactoryGirl.create(:user_yamada)
      FactoryGirl.create(:user_suzuki)
      pattern = [
        {
          id: 3,
          user_id: 3,
          title: "テストエントリー(2014-09-10 00:00:00)",
          uuid: "aabbccdd",
          stock_count: 15,
          comment_count: 1,
          hatebu_count: 4,
          entry_created: "2014-09-10T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "php"
            },
            {
              id: Fixnum,
              tag_name: "ruby"
            }
          ]
        },
        {
          id: 2,
          user_id: 2,
          title: "テストエントリー(2014-09-22 00:00:00)",
          uuid: "aabbccdd",
          stock_count: 3,
          comment_count: 99,
          hatebu_count: 33,
          entry_created: "2014-09-22T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "php"
            }
          ]
        }
      ].ordered!
      get "/api/v1/entries?tag=php"
      expect(response.status).to eq(200)
      expect(response.body).to match_json_expression(pattern)
    end
  end

  describe "GET /api/v1/entries?orderby=comment_count" do
    it "shows expected entries ordered by commnet_count" do
      FactoryGirl.create(:user_tanaka)
      FactoryGirl.create(:user_yamada)
      FactoryGirl.create(:user_suzuki)
      pattern = [
        {
          id: 2,
          user_id: 2,
          title: "テストエントリー(2014-09-22 00:00:00)",
          uuid: "aabbccdd",
          stock_count: 3,
          comment_count: 99,
          hatebu_count: 33,
          entry_created: "2014-09-22T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "php"
            }
          ]
        },
        {
          id: 1,
          title: "テストエントリー(2014-09-01 00:00:00)",
          user_id: 1,
          uuid: "aabbccdd",
          stock_count: 10,
          hatebu_count: 20,
          comment_count: 5,
          entry_created: "2014-09-01T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "ruby"
            }
          ]
        },
        {
          id: 3,
          user_id: 3,
          title: "テストエントリー(2014-09-10 00:00:00)",
          uuid: "aabbccdd",
          stock_count: 15,
          comment_count: 1,
          hatebu_count: 4,
          entry_created: "2014-09-10T00:00:00.000+09:00",
          created_at: /.+/,
          updated_at: /.+/,
          tags: [
            {
              id: Fixnum,
              tag_name: "php"
            },
            {
              id: Fixnum,
              tag_name: "ruby"
            }
          ]
        }
      ].ordered!
      get "/api/v1/entries?orderby=comment_count"
      expect(response.status).to eq(200)
      expect(response.body).to match_json_expression(pattern)
    end
  end

  describe 'GET /api/v1/tags' do
    it "shows expected tags" do
      FactoryGirl.create(:user_yamada)
      pattern = [
        {
          id: Fixnum,
          tag_name: "php",
          entries: [
            {
              id: 2,
              user_id: 2,
              title: "テストエントリー(2014-09-22 00:00:00)",
              uuid: "aabbccdd",
              stock_count: 3,
              comment_count: 99,
              hatebu_count: 33,
              entry_created: "2014-09-22T00:00:00.000+09:00",
              created_at: /.+/,
              updated_at: /.+/
            }
          ]
        }
      ]
      get "/api/v1/tags"
      expect(response.status).to eq(200)
      expect(response.body).to match_json_expression(pattern)
    end
  end

  describe 'GET /api/v1/users' do
    it "shows expected users" do
      FactoryGirl.create(:user_tanaka)
      pattern = [
        {
          id: 1,
          user_name: "tanaka",
          following_users: 33,
          followers: 44,
          items: 55,
          created_at: /.+/,
          updated_at: /.+/,
          entries: [
            {
              id: 1,
              user_id: 1,
              title: "テストエントリー(2014-09-01 00:00:00)",
              uuid: "aabbccdd",
              stock_count: 10,
              comment_count: 5,
              hatebu_count: 20,
              entry_created: "2014-09-01T00:00:00.000+09:00",
              created_at: /.+/,
              updated_at: /.+/
            }
          ]
        }
      ]
      get "/api/v1/users"
      expect(response.status).to eq(200)
      expect(response.body).to match_json_expression(pattern)
    end
  end
end
