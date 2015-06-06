class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" } , :default_url => "/images/:style/flower.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :role

  before_save :assign_role

   validates :password,
    :confirmation => {:message => "Hasła nie pasują"}

    def assign_role
      self.role = Role.find_by name: "Regular" if self.role.nil?
    end

    def admin?
    	self.role.name == "Admin"
    end

    def regular?
      self.role.name == "Regular"
    end



end
