class RemoveCircleColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :circles, :user_id, :integer
    remove_column :circles, :book_id, :integer
  end
end
