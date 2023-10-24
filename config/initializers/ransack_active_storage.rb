# frozen_string_literal: true

Rails.application.config.to_prepare do
  ActiveStorage::Attachment.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[blob_id created_at id name record_id record_type]
    end
  end
end
