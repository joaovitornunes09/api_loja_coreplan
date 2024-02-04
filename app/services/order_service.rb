class OrderService < ApplicationController
    def CreateOrder(order, products)
        order_id = order.id
        offer    = Offer.find_by(product_id: nil)

        get_price_with_discount_items(products)

        permitted_order_items = products.map { |item| item.permit(:product_id, :quantity, :price_with_discount) }
  
        permitted_order_items.map! { |item| item.merge(order_id: order_id) }
  
        order_items = OrderItem.create(permitted_order_items)

        if order_items.all?(&:valid?)
            total_value = order_items.sum { |order_item| order_item.product.price * order_item.quantity }
            total_value_with_discounts = order_items.sum { |order_item| order_item.price_with_discount * order_item.quantity }
      
            if offer
              total_value_with_discounts -= (total_value_with_discounts * (offer.discount_percent / 100.0)).round(2)
            end

            order_items.map do | order_item | 
              product = order_item.product
              { 
                name: product.name,
                description: product.description,
                original_price: product.price,
                price_with_discount: order_item.price_with_discount,
                quantity: order_item.quantity
              }
            end
      
            order_summary = {
              order_id: order_id,
              total_value: total_value.round(2),
              total_value_with_discounts: total_value_with_discounts.round(2)
            }

            @resume_order = ResumeOrder.new(order_summary)

            order_summary[:order_items] = order_items
      
            if @resume_order.save
              return order_summary
            else
              return false
            end
        end
    end

end