require 'spec_helper'

describe ProjectsController do

  before(:each) do
    @token = '12345'
    @user = User.create! email: 'user@mail.com', password: 'test1234'
    @user.token = @token
    @user.save!
    @project = Project.create! name: 'Project1', description: 'Project1 Description'
  end

  it "GET index" do
    get :index, format: :json, token: @token
    response.body.should eq([@project].to_json)
  end

  it "GET show" do
    get :show, id: @project.id, format: :json, token: @token
    response.body.should eq(@project.to_json)
  end


  it "POST create" do
    post :create, project: {name: 'Project2', description: 'Project2 Description'}, format: :json, token: @token
    response.status.should eq(200)
    res = JSON.parse(response.body)
    res['name'].should eq('Project2')
    res['description'].should eq('Project2 Description')
  end

  it "PUT update" do
    put :update, id: @project.id, project: {name: 'Project2', description: 'Project2 Description'}, format: :json, token: @token
    response.status.should eq(200)
    res = JSON.parse(response.body)
    res['name'].should eq('Project2')
    res['description'].should eq('Project2 Description')
  end

  it "DELETE destroy" do
    delete :destroy, id: @project.id, format: :json, token: @token
    response.status.should eq(200)
  end


end
