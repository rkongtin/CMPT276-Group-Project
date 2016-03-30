class House < ActiveRecord::Base
    validates :address, :price, :sqft, :amenities, :contact_info, :pictures, presence: true
    validates :price, :sqft, :contact_info, numericality: true
end
