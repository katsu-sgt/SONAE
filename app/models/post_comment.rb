class PostComment < ApplicationRecord
  belongs_to :user_prams
  belongs_to :post
end
