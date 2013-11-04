require 'spec_helper'

describe Directory do

  before(:each) do
    @project = Project.create! name: 'Project1', description: 'Project1 Description'
  end

  context "with valid argumets" do
    it "is valid" do
      expect( @project.directories.new(name: 'Knowledge Base') ).to be_valid
    end
  end

  context "with empty name"  do
    it "is invalid" do
      directory = @project.directories.new()
      expect( directory ).to be_invalid
      expect( directory.errors.get(:name) ).to match_array(["can't be blank"])
    end
  end

  context "with not unique name" do
    context "in the same project" do
      it "is invalid" do
        another_directory = @project.directories.create!(name: 'Knowledge Base')
        directory = @project.directories.new(name: 'Knowledge Base')
        expect( directory ).to be_invalid
        expect( directory.errors.get(:name) ).to match_array(["has already been taken"])        
      end
    end

    context "in different projects" do
      it "is invalid" do
        @another_project = Project.create! name: 'Project2', description: 'Project2 Description'
        another_directory = @another_project.directories.create!(name: 'Knowledge Base')
        directory = @project.directories.new(name: 'Knowledge Base')
        expect( directory ).to be_valid
      end
    end

  end

end
