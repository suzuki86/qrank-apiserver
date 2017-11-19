require 'spec_helper'
require 'rails_helper'
require 'json_expressions/rspec'

describe API do
  describe "GET /api/v1/something" do
    it "shows 404 not found" do
      get "/api/v1/something"
      expect(response.status).to eq(404)
      expect(response.body).to include "404 not found"
    end
  end

  describe "GET /api/v1/entries" do
    it "shows expected entries" do
      FactoryGirl.create(:user_tanaka)
      FactoryGirl.create(:user_yamada)
      FactoryGirl.create(:user_suzuki)

      get "/api/v1/entries"
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end
end
