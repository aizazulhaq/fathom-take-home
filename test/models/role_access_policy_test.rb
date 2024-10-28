# == Schema Information
#
# Table name: role_access_policies
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  creator_role_id :integer          not null
#  viewer_role_id  :integer          not null
#
# Indexes
#
#  index_role_access_policies_on_creator_and_viewer  (creator_role_id,viewer_role_id) UNIQUE
#  index_role_access_policies_on_creator_role_id     (creator_role_id)
#  index_role_access_policies_on_viewer_role_id      (viewer_role_id)
#
# Foreign Keys
#
#  creator_role_id  (creator_role_id => roles.id)
#  viewer_role_id   (viewer_role_id => roles.id)
#
require "test_helper"

class RoleAccessPolicyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
