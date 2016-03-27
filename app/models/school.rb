class School < ActiveRecord::Base
    validates :name, :address, presence: true #don't require a latitude or longitude maybe?
    validates :lat, :long, numericality: true
end
