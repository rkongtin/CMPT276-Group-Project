class House < ActiveRecord::Base
    validates :address, :lat, :long, :price, :sqft, :amenities, :contact_info, :pictures, presence: true
    validates :lat, :long, :price, :sqft, numericality: true #:contact_info not sure if this should be a num, so they can write stuff such as 604-111-2222 (with dashes)
    has_attached_file :pictures, :styles => { :small => "150x150>" },
                  :url  => "/assets/houses/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/houses/:id/:style/:basename.:extension"
    validates_attachment_presence :pictures
    validates_attachment_size :pictures, :less_than => 5.megabytes
    validates_attachment_content_type :pictures, :content_type => ['image/jpeg', 'image/png']
end
