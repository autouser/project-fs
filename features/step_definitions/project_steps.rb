Given(/^I have projects:$/) do |table|
  @projects = []
  table.raw.each do |row|
    @projects << Project.create!(name: row[0], description: row[1])
  end
end

When(/^I visit projects dasboard$/) do
  visit projects_path
  page.current_path.should eq('/projects')
end

Then(/^I see my projects$/) do
  @projects.each do |project|
    page.should have_text(project.name)
    page.should have_text(project.description)
  end
end

When(/^I create a new project with name "(.*?)" and description "(.*?)"$/) do |name, description|
  click_link "New Project"
  fill_in "Name", with: name
  fill_in "Description", with: description
  click_button "Create Project"
  @project = Project.find_by_name(name)
end

When(/^I update project "(.*?)" with name "(.*?)" and description "(.*?)"$/) do |old_name, new_name, new_description|
  @project = Project.find_by_name(old_name)
  click_link 'edit', href: edit_project_path(@project)
  fill_in "Name", with: new_name
  fill_in "Description", with: new_description
  click_button "Update Project"
  @project.reload
end

When(/^I delete project "(.*?)"$/) do |name|
  @project = Project.find_by_name(name)
  click_link 'delete', href: project_path(@project)
end

Then(/^I see the project created$/) do
    page.should have_text(@project.name)
    page.should have_text(@project.description)
    page.should have_text('Project was successfully created')
end

Then(/^I see the project updated$/) do
    page.should have_text(@project.name)
    page.should have_text(@project.description)
    page.should have_text('Project was successfully updated')
end

Then(/^I see the project deleted$/) do
    page.should have_no_text(@project.name)
    page.should have_no_text(@project.description)
    page.should have_text('Project was successfully deleted')
end