class Admin::DasboardController < Admin::BaseController
  def index
    @account_count = Account.count
    @category_count = Category.count
    @manufacturer_count = Manufacturer.count
    @product_count = Product.count
  end
end
