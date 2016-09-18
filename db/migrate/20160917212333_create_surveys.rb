class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.datetime :end_date
      t.string :password
      t.text :description

      t.timestamps null: false
    end
  end
end
