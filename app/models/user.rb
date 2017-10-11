class User < ApplicationRecord
  has_secure_password
  has_many :comments
  has_many :votes

  validates :username,
            presence: true,
            length: { minimum: 3 },
            uniqueness: { case_sensitive: false }
  validates :password,
            length: { minimum: 8 }

  has_many :links, dependent: :destroy
  # identifying owner of particular link
  def owns_link?(link)
    self == link.user
  end

  # define owner of a particular comment
  def owns_comment?(comment)
    self == comment.user
  end

  # upvote functionality
  def upvote(link)
    votes.create(upvote: 1, link: link)
  end

  # checks if user has already voted on a link
  def upvoted?(link)
    votes.exists?(upvote: 1, link: link)
  end

  # remove a vote on a link
  def remove_vote(link)
    votes.find_by(link: link).destroy
  end

  # DOWNVOTE FUNCTIONALITY
  def downvote(link)
    votes.create(downvote: 1, link: link)
  end

  def downvoted?(link)
    votes.exists?(downvote: 1, link: link)
  end
end
