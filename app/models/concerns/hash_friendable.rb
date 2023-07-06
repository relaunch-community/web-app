module HashFriendable
  extend ActiveSupport::Concern

  included do
    # https://norman.github.io/friendly_id/file.Guide.html
    # use column as-is
    friendly_id :hash_id

    validates :hash_id, presence: true
    validates :hash_id, uniqueness: { case_sensitive: false }

    before_validation :set_hash_id, on: :create
  end

  private

  def set_hash_id
    self.hash_id ||= Digest::UUID.uuid_v4
  end
end
