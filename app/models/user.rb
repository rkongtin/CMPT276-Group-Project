class User < ActiveRecord::Base
    #before_save { self.email = email.downcase }

    #validates :name, :email, :password, presence: true
    #validates :email, uniqueness: { case_sensitive: false } #Tutorial said doing this, rails will infer that uniqueness should be true
    #
    #validates :password, presence: true, length: { minimum: 6 }, confirmation: true

    before_save { self.email = email.to_s.downcase.gsub(/\s+/, '') } #bug is fixed, this converts everything to string; but afterwards updated email shows blank - Yong
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
