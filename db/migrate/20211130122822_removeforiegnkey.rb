class Removeforiegnkey < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :bugs, :users
    remove_foreign_key :bugs, :projects
    remove_foreign_key :projects, :users
    remove_foreign_key :user_projects, :users
    remove_foreign_key :user_projects, :projects
   
  end
end
