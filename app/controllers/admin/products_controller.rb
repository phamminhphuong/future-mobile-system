class Admin::ProductsController < Admin::BaseController
  before_action :load_product, except: %i(new index create)
  before_action :load_category_manufacturer, except: %i(index show destroy)

  def index
    @products = Product.select_product
  end

  def new
    @product = Product.new
    @image = @product.images.build
  end

  def create
    @product = Product.new product_params
    ActiveRecord::Base.transaction do
      @product.save
      params[:images]["image_link"].each do |image|
        @image = Image.create! product_id: @product.id, image_link: image
      end
      flash[:success] = t "successfully_create"
      redirect_to admin_products_url
    end
    rescue Exception
      @image = @product.images.build
      render :new
  end

  def show; end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @product.update product_params
      params[:images]["image_link"].each do |image|
        @image = Image.create! product_id: @product.id, image_link: image
      end
      flash[:success] = t "successfully_update"
      redirect_to admin_products_url
    end
    rescue Exception
      render :edit
  end

  private

  def product_params
    params.require(:product).permit :name, :quantity, :price, :description,
      :hot, :category_id, :manufacturer_id
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product.present?
    flash[:danger] = t "not_product"
    redirect_to admin_products_url
  end

  def load_category_manufacturer
    @categories = Category.select_category
    @manufacturers = Manufacturer.select_manufacturer
  end
end
