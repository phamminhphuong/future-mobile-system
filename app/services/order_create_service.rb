class OrderCreateService
  def initialize params
    @session = params[:session]
    @order = params[:order]
    @order_detail = params[:order_detail]
  end

  def create_order
    @session[:cart].each do |product_id, quantity|
      product = Product.find_by id: product_id
      return unless product
      detail = @order.order_details.build
      detail.quantity = quantity
      detail.price = product.price
      detail.total_price = quantity * product.price
      detail.product_id = product_id
      detail.save
    end
  end

  def new_order
    @session[:cart] ||= {}
    product_id = @order_detail[:product_id]
    quantity = @order_detail[:quantity].to_i
    if @session[:cart][product_id].nil?
      @session[:cart][product_id] = quantity
    else
      @session[:cart][product_id] += quantity
    end
  end
end
