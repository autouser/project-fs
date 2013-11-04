require 'spec_helper'

describe Document do

  before(:each) do
    @project = Project.create! name: 'Project1', description: 'Project1 Description'
    @directory = @project.directories.create! name: 'Dir'
  end

end
