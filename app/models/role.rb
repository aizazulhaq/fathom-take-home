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
class Role < ApplicationRecord
    has_many :users

    # Policies where this role is the creator
    has_many :created_policies,
             class_name: "RoleAccessPolicy",
             foreign_key: "creator_role_id",
             dependent: :destroy

    has_many :allowed_viewer_roles,
             through: :created_policies,
             source: :viewer_role

    # Policies where this role is the viewer
    has_many :viewable_policies,
             class_name: "RoleAccessPolicy",
             foreign_key: "viewer_role_id",
             dependent: :destroy

    has_many :accessible_creator_roles,
             through: :viewable_policies,
             source: :creator_role
end
