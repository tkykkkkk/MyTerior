class Genre < ApplicationRecord
    has_many :posts
    # validates :name, presence: true, uniqueness: true
    validates :name, presence: { message: "の登録に失敗しました：間取りを入力してください。" }
    validates :name, uniqueness: { message: "エラー：同じ名前で登録しないでください"}
    
    def self.looks(search, word)
      Genre.find_by("name LIKE ?", "%#{word}%")
    end 
end
