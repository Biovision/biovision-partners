# frozen_string_literal: true

# Helper methods for handling partners
module PartnersHelper
  # @param [Partner] entity
  # @param [String] text
  # @param [Hash] options
  def admin_partner_link(entity, text = entity.name, options = {})
    link_to(text, admin_partner_path(id: entity.id), options)
  end
end
