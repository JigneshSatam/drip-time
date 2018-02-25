module Archiver
  MONITORING_ATTRIBUTES = []
  extend ActiveSupport::Concern

  module ClassMethods
  end

  module InstanceMethods
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
      return (self.previous_changes.keys & self.class::MONITORING_ATTRIBUTES).present?
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

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
    self.create_class(receiver)
    receiver.after_commit :create_archive
    receiver.has_many :archived, class_name: "Archived" + receiver.name, foreign_key: "archiver_id"
  end

  def self.create_class(receiver)
    klass = Class.new(Archived) do
      attr_accessor :changes_made

      belongs_to receiver.name.underscore.to_sym, foreign_key: 'archiver_id'

      before_create :build_changes

      has_many :modifications, as: :archivable

      def build_changes
        changes_made.each do |name, values|
          self.modifications.build(attribute_name: name, from: values[0], to: values[1])
        end
      end
    end
    Object.const_set "Archived#{receiver}", klass
  end
end
