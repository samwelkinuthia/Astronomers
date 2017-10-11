class Link < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :url,
            format: { with: %r{\Ahttps?://} },
            allow_blank: true

  def comment_count
    comments.length
  end

  def upvotes
    votes.sum(:upvote)
  end
end
