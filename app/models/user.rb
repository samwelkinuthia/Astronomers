class User < ApplicationRecord
  has_secure_password
  has_many :comments
  validates :username,
              presence: true,
              length: {minimum: 3},
              uniqueness:{case_sensitive: false}
  validates :password,
              length: {minimum: 8}

  has_many :links, dependent: :destroy

  def owns_link?(link)
    self == link.user
  end

  def owns_comment?(comment)
    self == comment.user
  end
end
