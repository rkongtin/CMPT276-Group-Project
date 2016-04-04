class User < ActiveRecord::Base

    before_save { self.email = email.to_s.downcase.gsub(/\s+/, '') } #(datatype) bug is fixed, this converts everything to string; but afterwards updated email shows blank - Yong
    validates :name, presence: true, length: { maximum: 50 } #valides that name is present (not blank)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, #validate email is in proper email form
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
    has_secure_password #used to hash the password, so a password of P@$$w0rd would be something like asldifkj0u98awuejjsPOIJ0fasjofsjf (if DB is hacked, hackers can't read passwords)
    validates :password, presence: true, length: { minimum: 6 }, :if => :password #make sure there is a password and that it has minimum length of 6
    validates :pictures, presence: true
    has_attached_file :pictures, :styles => { :small => "150x150>" },
                  :url  => "/assets/users/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"
    validates_attachment_presence :pictures
    validates_attachment_size :pictures, :less_than => 5.megabytes
    validates_attachment_content_type :pictures, :content_type => ['image/jpeg', 'image/png']
    
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
end
