class Insurance < ApplicationRecord

  ## API to track columns - grade and status
  # i = Insurance.create(valid_params)
  # i.reload.archived #=> [one ArchivedInsurance object] [1]
  # i.update_attribute :grade, 'FooBar'
  # i.reload.archived #=> [two or more ArchivedInsurance objects] [2]
  # i.status = 'rejected'; i.save
  # i.reload.archived #=> [more ArchivedInsurance objects] [3]

  validates :grade, presence: true
  belongs_to :exporter

  include Archiver
  MONITORING_ATTRIBUTES = ["grade", "status"]
end
