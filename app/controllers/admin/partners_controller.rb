# frozen_string_literal: true

# Administrative part of partners management
class Admin::PartnersController < AdminController
  include EntityPriority
  include ToggleableEntity

  before_action :set_entity, except: :index

  # get /admin/partners
  def index
    @collection = Partner.list_for_administration
  end

  # get /admin/partners/:id
  def show
  end

  private

  def set_entity
    @entity = Partner.find_by(id: params[:id])
    handle_http_404('Cannot find partner') if @entity.nil?
  end

  def restrict_access
    component_restriction Biovision::Components::PartnersComponent
  end
end
