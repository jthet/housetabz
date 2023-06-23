class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_one :member
  has_many :charges
  has_many :payments
  belongs_to :house, optional: true
  
  validates :username, presence: true, uniqueness: true
  
end
