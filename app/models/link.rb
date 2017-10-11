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

  scope :newest, -> { order(created_at: :desc) }

# MODEL METHODS
  # counting the total number of comments a link has
  def comment_count
    comments.length
  end
  #sum of upvotes for particular link
  def upvotes
    votes.sum(:upvote)
  end
  #downvotes
  def downvotes
    votes.sum(:downvote)
  end
  #calculating hotscore algorithm
  def calc_hot_score
    points = upvotes - downvotes
    time_ago_in_hours = ((Time.now - created_at) / 3600).round
    score = hot_score(points, time_ago_in_hours)

    update_attributes(points: points, hot_score: score)
  end

  scope :hottest, -> { order(hot_score: :desc) }

  private

  def hot_score(points, time_ago_in_hours, gravity = 1.8)
    #subtract 1 from points as defaut point value is one
    (points - 1) / (time_ago_in_hours + 2) ** gravity
  end
end
