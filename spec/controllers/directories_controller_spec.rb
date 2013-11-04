require 'spec_helper'

describe DirectoriesController do

  before(:each) do
    @token = '12345'
    @user = User.create! email: 'user@mail.com', password: 'test1234'
    @user.token = @token
    @user.save!
    @project = Project.create! name: 'Project1', description: 'Project1 Description'
    @directory = @project.directories.create! name: 'Dir1'
  end

  it "GET index" do
    get :index, project_id: @project.id, format: :json, token: @token
    response.body.should eq([@directory].to_json)
  end

  it "GET show" do
    get :show, project_id: @project.id, id: @directory.id, format: :json, token: @token
    response.body.should eq(@directory.to_json)
  end


  it "POST create" do
    post :create, project_id: @project.id, directory: {name: 'Dir1.1', parent_id: @directory.id}, format: :json, token: @token
    response.status.should eq(200)
    res = JSON.parse(response.body)
    res['name'].should eq('Dir1.1')
    res['ancestry'].should eq(@directory.id.to_s)
  end

  it "PUT update" do
    put :update, project_id: @project.id, id: @directory.id, directory: {name: 'Dir1_'}, format: :json, token: @token
    response.status.should eq(200)
    res = JSON.parse(response.body)
    res['name'].should eq('Dir1_')
  end

  it "DELETE destroy" do
    delete :destroy, project_id: @project.id, id: @directory.id, format: :json, token: @token
    response.status.should eq(200)
  end


  it "POST files" do
    filepath =  "#{Rails.root}/spec/support/test.doc"
    file = Rack::Test::UploadedFile.new(filepath,'text/plain')
    post :files, project_id: @project.id, id: @directory.id, document: {file: file}, format: :json, token: @token
    response.status.should eq(200)
    response.body.should eq('appended')
  end

end
