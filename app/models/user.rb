class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum user_type: [:manager, :developer, :qlty_as]
        

  has_many :projects , dependent: :destroy
  has_many :bugs, dependent: :destroy
  

  has_many :users_projects
  has_many :projects, through: :users_projects 



  def index
    case current_user.role
      when :admin
        @installations = Installation.all
      when :registered
        @installations = current_user.installations
      else 
        @installations = current_user.installations.first
    end
  end 
  def admin?
    self.role == "admin"
  end

  def registered?
    self.role == "registered"
  end
end
