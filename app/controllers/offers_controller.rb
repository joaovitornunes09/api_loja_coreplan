class OffersController < ApplicationController
  before_action :authorize, except: [:show, :index, :get_partial_order_value]
  before_action :needsAdminUser, only: %i[ update destroy create ]
  before_action :set_offer, only: %i[ show update destroy ]

  # GET /offers
  def index
    @offers = Offer.where(product_id: nil)

    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @offers}
  end

  # GET /offers/1
  def show
    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @offer}
  end

  # POST /offers
  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: @offer}, status: :created, location: @offer
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @offer.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: @offer.slice(:id, :name, :description, :discount_percent, :product_id)}
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @offer.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /offers/1
  def destroy
    if @offer.destroy
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: "Oferta excluida com sucesso."}
    else 
      render json: { status: false, message: "Erro ao excluir oferta.", data: @offer.errors }, status: :unprocessable_entity
    end
  end

  
  def get_partial_order_value
    @offer           = Offer.find_by(product_id: nil)
    partial_value    = params[:value].to_f

    discounted_value = partial_value - (partial_value * @offer.discount_percent / 100)
    discounted_value.round(2)

    render json: {status: true ,message: "Requisição realizada com sucesso.", data: discounted_value}

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def offer_params
      params.require(:offer).permit(:name, :description, :discount_percent, :product_id, :value)
    end
end
