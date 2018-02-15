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

  after_commit :create_archive

  has_many :archived, class_name: "ArchivedInsurance"

  MONITORING_ATTRIBUTES = ["grade", "status"]

  def create_archive
    model_action = self.get_model_action
    if model_action == 'update' && !should_create_archive_on_update
      return
    end
    archived_snapshot = self.archived.build(snapshot: self.attributes, model_action: model_action)
    archived_snapshot.changes_made = self.previous_changes
    archived_snapshot.save
  end

  def should_create_archive_on_update
    model_attribute_changed = false
    self.previous_changes.keys.each do |key|
      if MONITORING_ATTRIBUTES.include?(key)
        model_attribute_changed = true
        break
      end
    end
    return model_attribute_changed
  end

  def get_model_action
    if self.previous_changes["id"].present?
      return "create"
    elsif self.destroyed?
      return "destroy"
    else
      return "update"
    end
  end
end
