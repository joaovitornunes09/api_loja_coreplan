class ProductsController < ApplicationController
  before_action :authorize, except: [:show, :index]
  before_action :needsAdminUser, only: %i[ update destroy create ]
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all
    verify_discounts(@products)
  
    # Mapear os produtos para um formato que inclua as ofertas
    products_with_offers = set_values_offer_products(@products)
  
    render json: { status: true, message: "Requisição realizada com sucesso.", data: products_with_offers }
  end

  # GET /products/1
  def show
    product_with_offers = set_values_offer_products([@product])

    render json: {status: true ,message: "Requisição realizada com sucesso.", data: product_with_offers}
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: @product}, status: :created, location: @product
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @product.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: @product.slice(:name, :price, :description)}
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @product.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    if @product.destroy
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: "Produto excluido com sucesso."}
    else 
      render json: { status: false, message: "Erro ao excluir o produto.", data: @product.errors }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      begin
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @product = nil
      end

      unless @product
        render json: {status: false, message: "Erro ao realizar requisição.", data: "Produto não encontrado."}, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def product_params
      if params[:products].present?
        params.require(:products)
      else
        params.require(:product).permit(:name, :description, :price)
      end
    end

    def verify_discounts(products)
      return unless products
  
      products.each do |product|
        offer          = Offer.find_by(product_id: product.id)
        product.offers = [offer].compact
      end
    end

    def set_values_offer_products(products)
      return unless products
    
      products.map do |product|
        {
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          offers: if product.offers.present?
            {
              name: product.offers.first.name,
              discount_percent: product.offers.first.discount_percent,
              value_with_discount: calculate_discounted_value(product.price, product.offers.first.discount_percent)
            }
            else
              nil
            end
        }
      end
    end
end
