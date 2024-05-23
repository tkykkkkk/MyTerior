class PostComment < ApplicationRecord
belongs_to :user
belongs_to :post

validates :post_commet, presence: true
end
