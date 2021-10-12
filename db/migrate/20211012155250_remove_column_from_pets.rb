class RemoveColumnFromPets < ActiveRecord::Migration[6.0]
  def change
    remove_column :pets, :type, :string
  end
end
