class Genre < ApplicationRecord
    has_many :posts, dependent: :destroy
    
    validates :name, presence: true
    
    def self.looks(search, word)
    Genre.where("caption LIKE ?", "%#{word}%")
    end 
end
