require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  let(:team) { create(:team) }

  it { should belong_to :team }

  it { should respond_to :email }
  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :web_site }

  describe "scopes" do
    it "should filter by team" do
      team.users.push(user)
      User.by_team(team.id).should include(user)
    end
  end

  describe "#full_name" do
    it "should return full user name" do
      expect(user.full_name).to eq(user.first_name + ' ' + user.last_name)
    end
  end

  describe "#status=" do
    before do
      user.status= status
    end
    
    context "when given an accepted value" do
      let(:status) { :in }
      it "should write the enumerated value in the database" do
        expect(user.send(:read_attribute, :status)).to eql User::STATUSES[status]
      end      
    end
    
    context "when given an unaccepted value" do
      let(:status) { :bad_status }
      it "should write nil in the database" do
        expect(user.send(:read_attribute, :status)).to be_nil
      end      
      
    end
  end

  describe "#status" do
    before do
      user.status= status
    end
    
    context "when given an accepted value" do
      let(:status) { :in }
      it "should write the enumerated value in the database" do
        expect(user.status).to eql(:in)
      end      
    end
    
    context "when given an unaccepted value" do
      let(:status) { :bad_status }
      it "should write nil in the database" do
        expect(user.status).to be_nil
      end      
      
    end
  end

  describe "#current_sign_in_ip and #last_sign_in_ip" do
    describe "#current_sign_in_ip= (setter)" do
      before do
        user.current_sign_in_ip= current_sign_in_ip
      end
      
      context "when given an accepted value" do
        let(:current_sign_in_ip) { "127.0.0.1" }
        it "should write the converted to integer value in the database" do
          expect(user.send(:read_attribute, :current_sign_in_ip)).to eql(2130706433)
        end
      end

      context "when given an unaccepted value" do
        let(:current_sign_in_ip) { "127.0.0" }
        it "should write nil in the database" do
          expect(user.send(:read_attribute, :current_sign_in_ip)).to be_nil
        end
      end
    end
    describe "#current_sign_in_ip (getter)" do
      before do
        user.current_sign_in_ip= current_sign_in_ip
      end
      
      context "when given an accepted value" do
        let(:current_sign_in_ip) { "127.0.0.1" }
        it "should get the converted back to string value in the database" do
          expect(user.current_sign_in_ip).to eql("127.0.0.1")
        end
      end

      context "when given an unaccepted value" do
        let(:current_sign_in_ip) { "127.0.0" }
        it "should get nil from the database" do
          expect(user.current_sign_in_ip).to be_nil
        end
      end
    end
  end

  User.destroy_all

end
