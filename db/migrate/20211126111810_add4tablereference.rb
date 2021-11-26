class Add4tablereference < ActiveRecord::Migration[6.1]
  def change
   
    add_reference :bugs, :user, foreign_key: true
    add_reference :bugs, :project, foreign_key: true
    add_reference :projects, :user, foreign_key:  true
    add_reference :user_projects, :user, foreign_key: true
    add_reference :user_projects, :project, foreign_key: true
    
  end
end
