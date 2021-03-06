class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: 'User'
  belongs_to :previous_state, class_name: 'State'
  belongs_to :state
  validates :text, presence: true
  delegate :project, to: :ticket
  scope :persisted, lambda { where.not(id: nil) }
  before_create :set_previous_state
  after_create :set_ticket_state
  attr_accessor :tag_names
  after_create :associate_tags_with_ticket

  private

  def associate_tags_with_ticket
    if tag_names
      tag_names.split.each do |name|
        ticket.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

  private
  def set_previous_state
    self.previous_state = ticket.state
  end

  private

  def set_ticket_state
    ticket.state = state
    ticket.save!
  end

end
