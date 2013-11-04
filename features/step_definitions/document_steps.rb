path = "#{Rails.root}/spec/fixtures/files/sample1.doc"

When(/^I upload document "(.*?)" to the directory$/) do |filename|

  click_link "Upload"
  attach_file "document[file]", "#{Rails.root}/features/support/#{filename}"

  @document_name = filename

end

Given(/^I have document "(.*?)" in directory "(.*?)"$/) do |filename, directory|

  @directory = Directory.find_by_name(directory)

  @document = @directory.documents.new
  @document.status = 'published'
  @document.file = File.open("#{Rails.root}/features/support/#{filename}")
  @document.save!

  @document_name = filename
end

When(/^I delete the document "(.*?)"$/) do |arg1|
  click_link "delete", href: project_directory_document_path(@project, @directory, @document)
end

Then(/^I see no document$/) do
  page.should have_no_text(@document_name)  
  page.should have_text('deleted')
end

Then(/^I see the document$/) do
  page.should have_text(@document_name)
  page.should have_text("3596 b")
end
