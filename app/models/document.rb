class Document < ActiveRecord::Base

  attr_accessible :file

  belongs_to :directory

  mount_uploader :file, FileUploader

 end
