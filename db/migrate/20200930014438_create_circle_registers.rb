class CreateCircleRegisters < ActiveRecord::Migration[5.2]
  def change
    create_table :circle_registers do |t|
      t.integer :user_id
      t.integer :circle_id

      t.timestamps
    end
  end
end
