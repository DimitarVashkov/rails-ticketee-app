class Project < ApplicationRecord
  validates :name, presence: true
  # delete_all is faster than destroy as destroy gets called on
  # every single object of the referenced class
  has_many :tickets, dependent: :delete_all
  has_many :roles, dependent: :delete_all
end
