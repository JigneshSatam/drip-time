class Modification < ApplicationRecord
  belongs_to :archivable, polymorphic: true
end
