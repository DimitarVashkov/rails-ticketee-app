class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"
  validates :name, presence: true
  validates :description, presence: true
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy
  belongs_to :state
  accepts_nested_attributes_for :attachments, reject_if: :all_blank
end
