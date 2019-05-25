# frozen_string_literal: true

# Handling partners
class PartnersController < AdminController
  before_action :set_entity, only: %i[edit update destroy]

  # post /partners/check
  def check
    @entity = Partner.instance_for_check(params[:entity_id], entity_parameters)

    render 'shared/forms/check'
  end

  # get /partners/new
  def new
    @entity = Partner.new
  end

  # post /partners
  def create
    @entity = Partner.new(entity_parameters)
    if @entity.save
      form_processed_ok(admin_partner_path(id: @entity.id))
    else
      form_processed_with_error(:new)
    end
  end

  # get /partners/:id/edit
  def edit
  end

  # patch /partners/:id
  def update
    if @entity.update entity_parameters
      form_processed_ok(admin_partner_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /partners/:id
  def destroy
    flash[:notice] = t('partners.destroy.success') if @entity.destroy

    redirect_to(admin_partners_path)
  end

  protected

  def restrict_access
    component_restriction Biovision::Components::PartnersComponent
  end

  def set_entity
    @entity = Partner.find_by(id: params[:id])

    handle_http_404('Cannot find partner') if @entity.nil?
  end

  def entity_parameters
    params.require(:partner).permit(Partner.entity_parameters)
  end
end
