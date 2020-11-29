class CreateCircles < ActiveRecord::Migration[5.2]
  def change
    create_table :circles do |t|
      t.string :name
      t.integer :user_id
      t.integer :book_id
      t.integer :circle_id
      t.string :image_name

      t.timestamps
    end
  end
end
