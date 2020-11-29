class AddUserIdToCircle < ActiveRecord::Migration[5.2]
  def change
    add_column :circles, :make_user_id, :integer
  end
end
