module VisibilityAdjustable
  extend ActiveSupport::Concern

  VISIBILITY_PUBLIC = "Public"
  VISIBILITY_INTERNAL = "Internal (members-only)"
  VISIBILITY_PRIVATE = "Private (admins-only)"
  included do
    # https://norman.github.io/friendly_id/file.Guide.html
    # use column as-is

    enum visibility: {
      VISIBILITY_PUBLIC => 0,
      VISIBILITY_INTERNAL => 1,
      VISIBILITY_PRIVATE => 2
    }
    validates :visibility, presence: true

    scope :with_visibility, ->(visibility) { where(visibility: visibility) }

    scope :publicly_visible, -> {
      with_visibility(VisibilityAdjustable::VISIBILITY_PUBLIC)
    }

    scope :internally_visible, -> {
      with_visibility(VisibilityAdjustable::VISIBILITY_INTERNAL)
    }

    scope :privately_visible, -> {
      with_visibility(VisibilityAdjustable::VISIBILITY_PRIVATE)
    }

    scope :publicly_or_internally_visible, -> {
      publicly_visible.or(internally_visible)
    }
  end
end
