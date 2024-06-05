class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
end
