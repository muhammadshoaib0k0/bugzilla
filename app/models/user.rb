class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #enum user_type: [:manager, :developer, :qa]
  validates :name, presence: true
  validates :user_type, presence: true      

  has_many :projects , dependent: :destroy
  has_many :bugs, dependent: :destroy
  

  has_many :user_projects
  has_many :projects, through: :user_projects 
  def developer?
    return user_type.eql?('developer')
  end
  
  def manager?
    return user_type.eql?('manager')
  end

  def qa?
    return user_type.eql?('qa')
  end


  
end
