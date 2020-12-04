class AddCircleIdToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :circle_id, :integer
  end
end
