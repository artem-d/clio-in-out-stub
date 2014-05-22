require 'spec_helper'

describe "Teams" do
  describe "GET /teams" do
    it "works! (now write some real specs)" do
      visit teams_path
      response.status.should be(200)
    end
  end
end
