class User < ActiveRecord::Base
    #before_save { self.email = email.downcase }
    
    #validates :name, :email, :password, presence: true
    #validates :email, uniqueness: { case_sensitive: false } #Tutorial said doing this, rails will infer that uniqueness should be true
    #
    #validates :password, presence: true, length: { minimum: 6 }, confirmation: true
    
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
