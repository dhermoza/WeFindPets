class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :size
      t.string :gender
      t.integer :age
      t.string :color
      t.string :breed
      t.string :status
      t.string :special_attributes
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
