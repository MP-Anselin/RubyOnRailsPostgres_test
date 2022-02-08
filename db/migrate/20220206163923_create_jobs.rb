class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :salary
      t.text :spoken_languages, array: true, default: []
      t.text :shift_dates, array: true, default: []
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
