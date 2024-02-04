class ResumeOrdersController < ApplicationController
  before_action :authorize
  before_action :set_resume_order, only: %i[ show update destroy get_resume_order_with_products ]

  # GET /resume_orders
  def index
    @resume_orders = ResumeOrder.all

    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @resume_orders}
  end

  # GET /resume_orders/1
  def show
    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @resume_order}
  end

  # POST /resume_orders
  def create
    order = Order.find_by(id: params[:order_id])
    order_items = order&.order_items
    offer = Offer.find_by(product_id: nil)

    if order_items
      total_value = order_items.sum { |order_item| order_item.product.price * order_item.quantity }
      total_value_with_discounts = order_items.sum { |order_item| order_item.price_with_discount * order_item.quantity }

      if offer
        total_value_with_discounts -= (total_value_with_discounts * (offer.discount_percent / 100.0)).round(2)
      end

      order_summary = {
        order_id: params[:order_id],
        total_value: total_value.round(2),
        total_value_with_discounts: total_value_with_discounts.round(2)
      }
      @resume_order = ResumeOrder.new(order_summary)

      if @resume_order.save
        render json: {status: true ,message: "Requisição realizada com sucesso.", data: @resume_order}, status: :created, location: @resume_order
      else
        render json: {status: false, message: "Erro ao realizar requisição.", data: @resume_order.errors}, status: :unprocessable_entity
      end
    end
    

    
  end

  # PATCH/PUT /resume_orders/1
  def update
    if @resume_order.update(product_params)
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: @resume_order.slice(:order_id, :total_value, :total_value_with_discounts)}
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @resume_order.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /resume_orders/1
  def destroy
    if @resume_order.destroy
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: "Produto excluido com sucesso."}
    else 
      render json: { status: false, message: "Erro ao excluir o produto.", data: @resume_order.errors }, status: :unprocessable_entity
    end
  end

  def get_resume_order_with_products
    order     = Order.find(@resume_order.order_id)
    if order
      products  = order.order_items.map do | order_item | 
        product = order_item.product
        { 
          name: product.name,
          description: product.description,
          original_price: product.price,
          price_with_discount: order_item.price_with_discount,
          quantity: order_item.quantity
        }
      end

      resume_order = {
        order: @resume_order,
        order_items: products
      }

      render json: {status: true ,message: "Requisição realizada com sucesso.", data: resume_order}
    else 
      render json: { status: false, message: "Erro ao realizar requisição.", data: "Pedido não encontrado" }, status: :not_found
    end
  end

  def get_user_resume_order_with_products
    if @user.user_type_id == 1
      orders_user = Order.all
    else
      orders_user = @user.orders
    end

      items = []
      orders_user.each do |order|
        products = order.order_items.map do |order_item|
          product = order_item.product
          {
            name: product.name,
            description: product.description,
            original_price: product.price,
            price_with_discount: order_item.price_with_discount,
            quantity: order_item.quantity
          }
        end

        items << { order: order.resume_orders.first, order_items: products }
      end
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: items}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resume_order
      @resume_order = ResumeOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resume_order_params
      params.require(:resume_order).permit(:order_id, :total_value, :total_value_with_discounts)
    end
end
