# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  self.table_name = 'admin_users'
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email id remember_created_at reset_password_sent_at reset_password_token updated_at]
  end
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { in: 6..128 }, on: :create
  validates :password, length: { in: 6..128 }, allow_blank: true, on: :update

end
