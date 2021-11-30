class Addcolum < ActiveRecord::Migration[6.1]
  def change
    add_column :bugs, :assign_to, :integer
    add_column :bugs, :deadline, :datetime
  end
end
