class CreateCaseResults < ActiveRecord::Migration[5.1]
  def change
    create_table :case_results do |t|
      t.integer :case_id
      t.text :result_array
      t.text :path_array
      t.string :case_name
      t.string :case_tag
      t.string :case_type

      t.timestamps
    end
  end
end
