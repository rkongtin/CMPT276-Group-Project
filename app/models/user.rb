class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    
    validates :name, :email, :password, presence: true
    validates :email, uniqueness: { case_sensitive: false } #Tutorial said doing this, rails will infer that uniqueness should be true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, confirmation: true
end
