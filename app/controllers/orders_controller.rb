class OrdersController < ApplicationController
  before_action :authorize
  before_action :needsAdminUser, only: %i[ update ]
  before_action :set_order, only: %i[ show update destroy ]

  # GET /orders
  def index
    @orders = @user.orders.all

    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @orders}
  end

  # GET /orders/1
  def show
    render json: {status: true ,message: "Requisição realizada com sucesso.", data: @order}
  end

  # POST /orders
  def create
    @order = Order.new(user: @user)

    if @order.save
      order_service = OrderService.new
      resume_order  = order_service.CreateOrder(@order, params[:order_items])
    end

    if resume_order
      render json: {status: true , message: "Requisição realizada com sucesso.", data: resume_order}, status: :created, location: @order
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @order.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: @order}
    else
      render json: {status: false, message: "Erro ao realizar requisição.", data: @order.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    unless (@order.user == @user || @user.user_type_id == 1)
      render json: { status: false, message: "Erro ao excluir o pedido.", data: "Você não tem permissão para excluir este pedido." }, status: :unauthorized
      return
    end

    if @order.destroy
      render json: {status: true ,message: "Requisição realizada com sucesso.", data: "Pedido excluido com sucesso."}
    else 
      render json: { status: false, message: "Erro ao excluir o pedido.", data: @order.errors }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      begin
        @order = Order.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @order = nil
      end

      unless @order
        render json: {status: false, message: "Erro ao realizar requisição.", data: "Pedido não encontrado."}, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :order_items)
    end
end
