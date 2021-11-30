class Bug < ApplicationRecord
	has_one_attached :img
    validates :title, uniqueness: true ,presence: true
  	validates :description, presence: true
  	validates :bug_type, absence: true
  	validates :status, absence: true
  	validates :user_id, presence: true
  	validates :project_id, presence: true
  	

  #	mount_uploader :image, AvatarUploader
  	
  	belongs_to :user
  	belongs_to :project
end
