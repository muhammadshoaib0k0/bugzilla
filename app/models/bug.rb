class Bug < ApplicationRecord
    # validates :title, presence: true
  	# validates :description, presence: true
  	# validates :type, presence: true
  	# validates :status, presence: true
  	# validates :user_id, presence: true
  	# validates :project_id, presence: true
  	

  #	mount_uploader :image, AvatarUploader
  	
  	belongs_to :user
  	belongs_to :project
end
