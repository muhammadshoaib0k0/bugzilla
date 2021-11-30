class Typechange < ActiveRecord::Migration[6.1]
  def change
    add_column :bugs, :bug_type, :string 
    remove_column :bugs, :type, :string
  end
end
