require 'spec_helper'

describe Project do

  context "with valid argumets" do
    it "is valid" do
      expect( Project.new(name: 'Project1', description: 'Project1 Description') ).to be_valid
    end
  end

  context "with empty name"  do
    it "is invalid" do
      project = Project.new(description: 'Project1 Description')
      expect( project ).to be_invalid
      expect( project.errors.get(:name) ).to match_array(["can't be blank"])
    end
  end

  context "with not unique name"  do
    it "is invalid" do
      another_project = Project.create!(name: 'Project1', description: 'Project1 Description')
      project = Project.new(name: 'Project1', description: 'Project1 Description')
      expect( project ).to be_invalid
      expect( project.errors.get(:name) ).to match_array(["has already been taken"])
    end
  end

end
