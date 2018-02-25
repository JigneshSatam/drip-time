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

  include Archiver
  MONITORING_ATTRIBUTES = ["name", "email", "address"]
end
