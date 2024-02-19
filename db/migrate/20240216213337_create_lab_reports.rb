class CreateLabReports < ActiveRecord::Migration[7.0]
  def change
    create_table :lab_reports do |t|
      t.string :title, limit: 250
      t.string :description, limit: 500
      t.string :grade
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
