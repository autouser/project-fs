class Directory < ActiveRecord::Base
  attr_accessible :ancestry, :name, :parent_id

  belongs_to :project
  has_many :documents

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :project_id

  has_ancestry orphan_strategy: :destroy

  before_save :process_defaults

  private

  def process_defaults
    self.project_id = self.parent.project_id if self.project_id.blank? && self.parent
  end

end
