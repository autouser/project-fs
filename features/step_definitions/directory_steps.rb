Given(/^I have directories for the project "(.*?)":$/) do |project_name, table|
  @project = Project.find_by_name(project_name)
  @directories = []
  table.hashes.each do |row|
    if row[:parent].blank?
      @directories << @project.directories.create!(name: row[:name])
    else
      @directories << Directory.find_by_name(row[:parent]).children.create!(name: row[:name])
    end
  end
end

When(/^I visit the project$/) do
  visit project_path(@project)
end

When(/^I choose the directory "(.*?)"$/) do |name|
  @directory = Directory.find_by_name(name)
  within "#tree" do
    click_link name
  end
end

When(/^I add a root directory "(.*?)"$/) do |name|
  click_link "Add", href: new_project_directory_path(@project)
  fill_in "Name", with: name
  click_button "Create Directory"
  @directory = Directory.find_by_name(name)
end

When(/^I add subdirectory "(.*?)"$/) do |name|
  @target_directory = @directory
  click_link 'Add Subdirectory'
  fill_in "Name", with: name
  click_button "Create Directory"
  @directory = Directory.find_by_name(name)
end

When(/^I update the directory with name "(.*?)"$/) do |name|
  click_link 'Edit'
  fill_in "Name", with: name
  click_button "Update Directory"
  @directory.reload
end

When(/^I delete the directory$/) do
  click_link 'Delete'
end

Then(/^I see no directory with name "(.*?)"$/) do |name|
    page.should have_no_text(name)
end

Then(/^I see the directory$/) do
  find('a.brand', text: @directory.name)
end



Then(/^I see the directory tree$/) do
  within('#tree tbody') do
    tds = page.all('td').to_a
    @directories.each do |dir|
      tds.shift.text.should eq(dir.name)
    end
  end
end
