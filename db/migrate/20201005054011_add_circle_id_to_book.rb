class AddCircleIdToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :circle_id, :integer
  end
end
