require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }
  let(:team) { create(:team) }

  before do
    sign_in user
  end
  def valid_attributes
    FactoryGirl.attributes_for(:user)
  end

  describe "GET index" do
    it "should render the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "should not include current user" do
      get :index
      assigns(:users).should_not include(user)
    end
    
    describe "with JSON request" do
      it "should respond with success" do
        get :index, :format => :json
        should respond_with 200
      end

      it "should respond with JSON data" do
        FactoryGirl.create(:user)
        get :index, :format => :json
        body = JSON.parse(response.body)
        body.size.should eq(1)
        body[0].should include('id')
        body[0].should include('status')
        body[0].should include('full_name')
      end
    end
  end

  describe "GET status" do
    before { get :status, :id => user.to_param, :format => :json }
    it "should respond with success" do
      should respond_with 200
    end

    it "should respond with JSON data" do
      body = JSON.parse(response.body)
      body.should include('id')
      body.should include('status')
      body.should include('full_name')
    end

    it "should return user data" do
      body = JSON.parse(response.body)
      body['id'].should eq(user.id)
      body['status'].should eq(user.status.to_s)
      body['full_name'].should eq(user.full_name)
    end
  end

  describe 'GET show' do
    it 'assigns the requested user as @user' do
      get :show, { id: user.to_param }
      assigns(:user).should eq(user)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested user as @user' do
      user.should be
      get :edit, { id: user.to_param }
      assigns(:user).should eq(user)
    end
  end

  describe 'PUT update' do
    before do
      user.should be
    end

    describe 'with valid params' do
      it 'updates the requested user' do
        User.any_instance.should_receive(:update_attributes).with({ 'email' => 'foo@bar.foo' })
        put :update, { id: user.to_param, user: { 'email' => 'foo@bar.foo' } }
      end

      it 'redirects to users' do
        put :update, { id: user.to_param, user: valid_attributes }
        response.should redirect_to(users_path)
      end
    end
  end

User.destroy_all

end
