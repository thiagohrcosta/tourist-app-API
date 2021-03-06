class Api::V1::CompaniesController < Api::V1::BaseController
  # Act as a token seria apenas para index e show, foi usado except geral para testes
  acts_as_token_authentication_handler_for User, except: [ :index, :show, :update, :create, :destroy ]

  before_action :set_company, only: [:show, :update, :destroy]

  def index
    @companies = policy_scope(Company)
    authorize @companies
  end

  def show;end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @company.update(company_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @company.destroy
    head :no_content
  end

  private

  def set_company
    @company = Company.find(params[:id])
    authorize @company
  end

  def company_params
    params.require(:company).permit(:user_id, :name, :logo)
  end

  def render_error
    render json: { errors: @company.errors.full_messages},
    status: :unprocessable_entity
  end
end
