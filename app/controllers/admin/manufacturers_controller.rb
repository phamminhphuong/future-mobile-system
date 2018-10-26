class Admin::ManufacturersController < Admin::BaseController
  before_action :load_manufacturer, except: %i(new index create)

  def index
    @manufacturers = Manufacturer.select_manufacturer
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new manufacturer_params
    if @manufacturer.save
      flash[:success] = t "successfully_create"
      redirect_to admin_manufacturers_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @manufacturer.update manufacturer_params
      flash[:success] = t "successfully_update"
      redirect_to admin_manufacturers_url
    else
      render :edit
    end
 end

  private

  def manufacturer_params
    params.require(:manufacturer).permit :name
  end

  def load_manufacturer
    @manufacturer = Manufacturer.find_by id: params[:id]
    return if @manufacturer.present?
    flash[:danger] = t "not_manufacturer"
    redirect_to admin_manufacturers_url
  end
end
