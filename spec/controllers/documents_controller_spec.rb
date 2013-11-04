require 'spec_helper'

describe DocumentsController do

  before(:each) do
    @token = '12345'
    @user = User.create! email: 'user@mail.com', password: 'test1234'
    @user.token = @token
    @user.save!

    @project = Project.create! name: 'Project1', description: 'Project1 Description'

    @directory = @project.directories.create! name: 'Dir1'

    @document = @directory.documents.new
    @document.status = 'published'
    @document.file = File.open("#{Rails.root}/spec/support/test.doc")
    @document.save!
  end

  it "GET show" do
    get :show, project_id: @project.id, directory_id: @directory.id, id: @document.id, format: :json, token: @token
    response.headers['Content-Disposition'].should eq('attachment; filename="test.doc"')
  end

  it "DELETE destroy" do
    delete :destroy, project_id: @project.id, directory_id: @directory.id, id: @document.id, format: :json, token: @token
    response.status.should eq(200)
  end

end
