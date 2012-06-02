require 'digest/sha2'
  
class User < ActiveRecord::Base
  attr_accessible :user_id
  validates :name, :presence => true, :uniqueness => true
 
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password

  validate  :password_must_be_present
  
  # add by TFY, 2012.06.02, 但是还没实现每个用户查看自己的订单信息
  has_many :orders, :dependent => :destroy
  # end
  
  # 定义ROLE_TYPES
  # by TYF, 2012, 05, 30
  ROLE_TYPES = ["Administrator", "Register_User"]
  # end
  
  # 判断是管理员Administrator还是普通用户（买家）Register_User
  # by TYF, 2012, 05, 30
  def is_admin
    role == 'Administrator'
  end
  def is_user
    role == 'Register_User'
  end  
  # end
  
  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end
  
  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  after_destroy :ensure_an_admin_remains

  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end 
  
  private

    def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
  
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end
