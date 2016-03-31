class House < ActiveRecord::Base
    validates :address, :price, :sqft, :amenities, :contact_info, :pictures, presence: true
    validates :price, :sqft, numericality: true #:contact_info not sure if this should be a num, so they can write stuff such as 604-111-2222 (with dashes)
end
