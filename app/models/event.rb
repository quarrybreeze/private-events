class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  
  has_many :attendances, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :attendances, source: :attendee

  scope :previous_events, -> { where(event_date: ..(Time.now)) }
  scope :future_events, -> { where(event_date: (Time.now)..) }

  def self.past
    where(event_date: ..(Time.now))
  end

  def self.future
    where(event_date: (Time.now)..)
  end

end
