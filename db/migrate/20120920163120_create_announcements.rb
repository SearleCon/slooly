class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :headline
      t.text :description
      t.string :posted_by

      t.timestamps
    end
  end
end
