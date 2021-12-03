class Bug < ApplicationRecord
	
    validates :title, uniqueness: true ,presence: true
  	validates :description, presence: true
  	validates :bug_type, presence: true
  #	validates :status, presence: true
  #	validates :assign_to, presence: true
  	validates :user_id, presence: true
  	validates :project_id, presence: true

  	mount_uploader :img, AvatarUploader
  	
  	belongs_to :user
  	belongs_to :project
end
