class HouseTabFee < ApplicationRecord
  belongs_to :user

  attribute :status, :string, default: 'unpaid'
end
