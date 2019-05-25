# frozen_string_literal: true

# Partner
#
# Attributes
#   created_at [DateTime]
#   image [SimpleImageUploader]
#   language_id [Language], optional
#   name [String]
#   priority [Integer]
#   url [String]
#   updated_at [DateTime]
#   visible [Boolean]
class Partner < ApplicationRecord
  include Checkable
  include FlatPriority
  include Toggleable

  NAME_LIMIT = 150
  URL_LIMIT = 255

  toggleable :visible

  mount_uploader :image, SimpleImageUploader

  belongs_to :language, optional: true

  validates_presence_of :name, :image
  validates_length_of :name, maximum: NAME_LIMIT
  validates_length_of :url, maximum: URL_LIMIT

  scope :visible, -> { where(visible: true) }
  scope :list_for_visitors, -> { visible.ordered_by_priority }
  scope :list_for_administration, -> { ordered_by_priority }

  def self.entity_parameters
    %i[image language_id name priority url visible]
  end

  def image_alt_text
    name
  end
end
