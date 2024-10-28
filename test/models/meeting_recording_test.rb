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
require "test_helper"

class MeetingRecordingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
