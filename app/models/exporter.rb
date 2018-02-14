class Exporter < ApplicationRecord
  has_secure_password
  before_save { self.email.downcase! }

  ## API to track columns - name, email, address
  ## It shouldn't track changes in password_digest
  # e = Exporter.create(valid_params)
  # e.reload.archived #=> [one ArchivedExporter object] [1]
  # e.update_attribute :name, 'FooBar'
  # e.reload.archived #=> [two or more ArchivedExporter objects] [2]
  # e.password = e.password_confirmation = 'newpassword'; e.save
  # e.reload.archived #=> should be same as [2]

  has_one :insurance

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :email, uniqueness: { case_sensitive: false },
                    presence: true,
                    length: { maximum: 255 }

  after_commit :create_archive

  has_many :archived, class_name: "ArchivedExporter"

  MONITORING_ATTRIBUTES = ["name", "email", "address"]

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
