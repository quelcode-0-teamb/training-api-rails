class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 16 }, uniqueness: true,
                   format: { with: /\A[a-zA-Z\d]+\z/ } # 英数字のみ
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i } # メール書式フォーマット
  has_secure_token
  has_secure_password

  has_many :measures, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :scores, dependent: :destroy
  # Routine
  has_many :routines, dependent: :destroy
  has_many :routine_exercises, through: :routines, dependent: :destroy
  # Follow
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id', dependent: :destroy, inverse_of: :commentable
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id', dependent: :destroy, inverse_of: :commentable
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  # FollowRequest
  has_many :active_relatioships_requests, class_name: 'RelationshipRequest',
                                          foreign_key: 'requester_id', dependent: :destroy,
                                          inverse_of: :commentable
  has_many :passive_relationships_requests, class_name: 'RelationshipRequest',
                                            foreign_key: 'recipient_id', dependent: :destroy,
                                            inverse_of: :commentable
  has_many :requests, through: :active_relatioships_requests, source: :recipient
  has_many :recipients, through: :passive_relationships_requests, source: :requester

  def follow(follow_user)
    raise(ActionController::BadRequest, '自分はフォローできません') and return if self == follow_user
    followings << follow_user
  end

  def unfollow(follow_user)
    active_relationships.find_by(followed_id: follow_user.id).destroy
  end

  def follow_request(request_user)
    raise(ActionController::BadRequest, '自分にフォローリクエストは送れません') and return if self == request_user
    requests << request_user
  end

  def request_cancel(pecipeint_user)
    active_relatioships_requests.find_by(recipient_id: pecipeint_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def follow_status(other_user)
    if followings.find_by(id: other_user).present?
      { "follow_status": 'フォロー中' }
    elsif requests.find_by(id: other_user).present?
      { "follow_status": 'フォローリクエスト中' }
    else
      { "follow_status": 'フォロ-していません' }
    end
  end
end
