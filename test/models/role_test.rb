# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  role_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_role_name  (role_name) UNIQUE
#
require "test_helper"

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end