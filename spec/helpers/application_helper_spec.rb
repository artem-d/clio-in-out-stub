require "spec_helper"

describe ApplicationHelper do

  let(:user) { create(:user) }
  let(:team) { create(:team) }
  
  describe "#name_with_status" do
    it "returns specially formated anchor tag" do
      helper.name_with_status(user.full_name, user.status, user.id).should
        have_selector('a', :href => "/users/#{user.id}", :class => "name", :text => user.full_name)
    end
  end

  describe "#link_to_team" do
    it "returns specially formated anchor tag" do
      team.users.push(user)
      helper.link_to_team(user).should
        have_selector('a', :href => "/?team_id=#{user.team.id}", :class => "name", :text => user.team.name)
    end
  end

end
