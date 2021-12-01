class Bug < ApplicationRecord
	
    validates :title, uniqueness: true ,presence: true
  	validates :description, presence: true
  	validates :bug_type, presence: true
  	# validates :status, optional: true
  	# validates :assign_to, optional: true
  	validates :user_id, presence: true
  	validates :project_id, presence: true

  	#mount_uploader :image, AvatarUploader
  	
  	belongs_to :user
  	belongs_to :project
end
