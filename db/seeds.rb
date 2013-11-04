DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

user1 = User.create! email: 'user@mail.com', password: 'test1234'

project1 = Project.create! name: 'Project1', description: 'Project1 Description'
project2 = Project.create! name: 'Project2', description: 'Project2 Description'

dir1 = project1.directories.create! name: 'Dir1'
dir11 = dir1.children.create! name: 'Dir11'
dir111 = dir11.children.create! name: 'Dir111'
dir112 = dir11.children.create! name: 'Dir112'
dir113 = dir11.children.create! name: 'Dir113'
dir12 = dir1.children.create! name: 'Dir12'

dir2 = project1.directories.create! name: 'Dir2'

dir_kb = project2.directories.create! name: 'Knowledge Base'
dir_faq = project2.directories.create! name: 'FAQ'