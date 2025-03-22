class Restaurant < ApplicationRecord
  has_many :galleries, dependent: :destroy
  has_one :menu, dependent: :destroy
  validates :name, :description, presence: true
end
