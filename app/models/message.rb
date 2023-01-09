class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  after_create_commit { broadcast_append_to room }
  before_create :confirm_participant

  def confirm_participant
    return unless room.is_private
    errors.add(:base, 'You are not a participant of this room') unless room.participants.exists?(user_id: user_id)
  end
end
