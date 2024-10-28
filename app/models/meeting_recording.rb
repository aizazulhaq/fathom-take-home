# == Schema Information
#
# Table name: meeting_recordings
#
#  id                 :integer          not null, primary key
#  recording_page_url :string           not null
#  thumbnail_url      :string           not null
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  creator_role_id    :integer          not null
#  creator_user_id    :integer          not null
#
# Indexes
#
#  index_meeting_recordings_on_creator_role_id  (creator_role_id)
#  index_meeting_recordings_on_creator_user_id  (creator_user_id)
#
# Foreign Keys
#
#  creator_role_id  (creator_role_id => roles.id)
#  creator_user_id  (creator_user_id => users.id)
#
class MeetingRecording < ApplicationRecord
  belongs_to :creator_user, class_name: "User", foreign_key: "creator_user_id"
  belongs_to :creator_role, class_name: "Role", foreign_key: "creator_role_id"

  def accessible_to?(user)
    RoleAccessPolicy
    .where(viewer_role_id: user.role_id, creator_role_id: self.creator_role_id)
    .exists?
  end

  def self.get_allowed_meetings(user)
    # start_time = Time.now
    # puts "user roe is: #{user.role_id}"
    # allowed_roles = user.role.accessible_creator_roles()
    # puts " user allowed roles #{allowed_roles.inspect}"
    # data = MeetingRecording.where(creator_role_id: allowed_roles)
    # duration_approach_1 = Time.now - start_time
    # puts "Approach 1 duration: #{duration_approach_1} seconds"


    # this aproach is faster
    # start_time = Time.now
    data = MeetingRecording.joins("INNER JOIN role_access_policies ON role_access_policies.creator_role_id = meeting_recordings.creator_role_id")
    .where(role_access_policies: { viewer_role_id: user.role_id })
    # duration_approach_2 = Time.now - start_time
    # puts "Approach 2 duration: #{duration_approach_2} seconds"

    data
  end
end
