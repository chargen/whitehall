class Api::OrganisationsController < PublicFacingController
  respond_to :json

  self.responder = Api::Responder

  def index
    respond_with Api::OrganisationPresenter.paginate(
      Organisation.order(:id), # Need to order by something for pagination to be deterministic
      view_context
    )
  end

  def show
    @organisation = Organisation.find_by_slug(params[:id])
    if @organisation
      respond_with Api::OrganisationPresenter.new(@organisation, view_context)
    else
      respond_with_not_found
    end
  end

private
  def respond_with_not_found
    respond_with Hash.new, status: :not_found
  end
end
