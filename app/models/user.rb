# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           not null
#  encrypted_password :string           default(""), not null
#  username           :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  role_id            :integer          not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_role_id   (role_id)
#  index_users_on_username  (username) UNIQUE
#
# Foreign Keys
#
#  role_id  (role_id => roles.id)
#
class User < ApplicationRecord
  # Device modules generats, email, encrypted password, created_at
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  has_many :meeting_recordings, foreign_key: "creator_user_id"
end
