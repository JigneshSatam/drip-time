class ArchivedInsurance < ApplicationRecord
  attr_accessor :changes_made

  belongs_to :insurance

  before_create :build_changes

  has_many :modifications, as: :archivable

  def build_changes
    changes_made.each do |name, values|
      self.modifications.build(attribute_name: name, from: values[0], to: values[1])
    end
  end
end
