class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      t.string :username
      t.string :name
      t.string :tag
      t.string :desc

      t.timestamps
    end
  end
end
