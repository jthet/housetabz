# app/models/tab.rb
class Tab < ApplicationRecord
    belongs_to :house
    has_many :bills, dependent: :destroy
    has_many :charges, through: :bills, dependent: :destroy
    attribute :month, :integer
    attribute :year, :integer
    attribute :paid, :boolean, default: false
  
    def self.ransackable_attributes(auth_object = nil)
        ["amount", "created_at", "house_id", "id", "month", "paid", "updated_at", "year",'bills_id']
      end

    def self.ransackable_associations(auth_object = nil)
        ["bills", 'house']
    end

    def update_paid_status
        self.paid = bills.all? { |bill| bill.status == 'paid' }
        save
      end
    # Add any additional methods or validations you may need
  end

  