require 'spec_helper'

describe TeamsController do

  let(:user) { create(:user) }
  let!(:team) { create(:team) }

  before do
    sign_in user
  end

  def valid_attributes
    FactoryGirl.attributes_for(:team)
  end

  def mock_user
    controller.stub(:current_user).and_return(user)
  end

  describe "GET index" do
    before do
      get :index
    end

    it "should render the index template" do
      expect(response).to render_template("index")
    end

    it "assigns @teams" do
      team.should be
      assigns(:teams).should eq([team])
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

  describe 'GET show' do
    it 'assigns the requested team as @team' do
      get :show, { id: team.to_param }
      assigns(:team).should eq(team)
    end
  end

  describe 'GET new' do
    it 'assigns a new team as @team' do
      get :new
      assigns(:team).should be_a_new(Team)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested team as @team' do
      team.should be
      get :edit, { id: team.to_param }
      assigns(:team).should eq(team)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Team' do
        expect do
          post :create, { team: valid_attributes }
        end.to change(Team, :count).by(1)
      end

      it 'assigns a newly created team as @team' do
        post :create, { team: valid_attributes }
        assigns(:team).should be_a(Team)
        assigns(:team).should be_persisted
      end

      it 'redirects to the created team' do
        post :create, { team: valid_attributes }
        response.should redirect_to(assigns(:team))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved team as @team' do
        Team.any_instance.stub(:save).and_return(false)
        post :create, { team: { 'name' => '' } }
        assigns(:team).should be_a_new(Team)
      end
    end
  end

  describe 'PUT update' do
    before do
      team.should be
    end

    describe 'with valid params' do
      it 'updates the requested team' do
        Team.any_instance.should_receive(:update_attributes).with({ 'name' => 'params' })
        put :update, { id: team.to_param, team: { 'name' => 'params' } }
      end

      it 'assigns the requested team as @team' do
        put :update, { id: team.to_param, team: valid_attributes }
        assigns(:team).should eq(team)
      end

      it 'redirects to the team' do
        put :update, { id: team.to_param, team: valid_attributes }
        response.should redirect_to(assigns(:team))
      end
    end

    describe 'with invalid params' do
      it 'assigns the team as @team' do
        Team.any_instance.stub(:save).and_return(false)
        put :update, { id: team.to_param, team: { 'name' => '' } }
        assigns(:team).should eq(team)
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      team.should be
    end

    it 'destroys the requested team' do
      expect do
        delete :destroy, { id: team.to_param }
      end.to change(Team, :count).by(-1)
    end

    it 'redirects to the teams list' do
      delete :destroy, { id: team.to_param }
      response.should redirect_to(assigns(:team))
    end
  end
  
  User.destroy_all

end
