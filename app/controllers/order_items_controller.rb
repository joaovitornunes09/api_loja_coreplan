class OrderItemsController < ApplicationController
  before_action :authorize
  before_action :set_order_item, only: %i[ show update destroy ]

  # GET /order_items
  def index
    @order_items = OrderItem.all

    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @order_items}
  end

  # GET /order_items/1
  def show
    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @order_item}
  end

  # POST /order_items
  def create
    order_id = params[:order_id]
    order_items = params[:order_items]
  
    get_price_with_discount_items(order_items)
  
    permitted_order_items = order_items.map { |item| item.permit(:product_id, :quantity, :price_with_discount) }
  
    permitted_order_items.map! { |item| item.merge(order_id: order_id) }
  
    created_order_items = OrderItem.create(permitted_order_items)
  
    if created_order_items.all?(&:valid?)
      render json: { status: true, message: "Requisição realizada com sucesso.", data: created_order_items }, status: :created
    else
      render json: { status: false, message: "Erro ao realizar requisição.", data: created_order_items.map { |item| item.errors } }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_items/1
  def update
    if @order_item.update(order_item_params)
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: @order_item.slice(:order_id, :product_id, :quantity, :price_with_discount)}
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @order_item.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /order_items/1
  def destroy
    if @order_item.destroy
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: "Item excluido do pedido com sucesso."}
    else 
      render json: { status: false, message: "Erro ao excluir o item do pedido.", data: @order_item.errors }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_item_params
      params.require(:order_item).permit(:order_id, :order_items, :product_id, :quantity, :price_with_discount)
    end
end
