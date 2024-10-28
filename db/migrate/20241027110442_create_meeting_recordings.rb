class CreateMeetingRecordings < ActiveRecord::Migration[7.0]
  def change
    create_table :meeting_recordings do |t|
      t.string :title, null: false
      t.string :thumbnail_url, null: false
      t.string :recording_page_url, null: false
      t.references :creator_user, null: false, foreign_key: { to_table: :users }
      t.references :creator_role, null: false, foreign_key: { to_table: :roles }
      t.timestamps
    end
  end
end
