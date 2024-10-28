# class CreateRoleAccessPolicies < ActiveRecord::Migration[7.2]
#   def change
#     create_table :role_access_policies do |t|
#       t.references :creator_role, polymorphic: true, null: false
#       t.references :viewer_role, polymorphic: true, null: false

#       t.timestamps
#     end
#   end
# end

class CreateRoleAccessPolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :role_access_policies do |t|
      t.references :creator_role, null: false, foreign_key: { to_table: :roles }
      t.references :viewer_role, null: false, foreign_key: { to_table: :roles }

      t.timestamps
    end

    add_index :role_access_policies, [ :creator_role_id, :viewer_role_id ], unique: true, name: 'index_role_access_policies_on_creator_and_viewer'
  end
end
