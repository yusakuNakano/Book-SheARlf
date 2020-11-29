class AddDefaultFragCircleRegister < ActiveRecord::Migration[5.2]
  def change
    add_column :circle_registers, :my_circle, :boolean, default: false, null:false
  end
end
