class AddUserIdToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :lend_user_id, :integer
  end
end
