class ChangeCircle < ActiveRecord::Migration[5.2]
  def change
    remove_column :circle_registers, :my_circle, :boolean
    add_column :circles, :my_circle, :boolean, default: false, null:false
  end
end
