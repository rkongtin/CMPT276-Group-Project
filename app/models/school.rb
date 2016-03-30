class School < ActiveRecord::Base
    validates :name, :address, presence: true
    validates :lat, :long, numericality: true #require lat and long to be some number, this way there's atleast some default value that can be parsed
    #geocoded_by :address
    #after_validation :geocode
end
