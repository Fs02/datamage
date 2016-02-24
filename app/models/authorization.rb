class Authorization
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid, type: String
  field :token, type: String
  field :secret, type: String

  belongs_to :user, index: true

  validates_presence_of :user_id, :uid, :provider

  index({ uid: 1, provider: 1 }, { unique: true })
end
