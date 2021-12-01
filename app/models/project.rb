class Project < ApplicationRecord
    validates :name, presence: true
  	validates :description, presence: true
  	validates :user_id, presence: true

  	has_many :bugs , dependent: :destroy
 
  	belongs_to :user
    has_many :user_projects
  	has_many :users, through: :user_projects
end
