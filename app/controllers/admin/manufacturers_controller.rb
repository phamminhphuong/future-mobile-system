class Admin::ManufacturersController < Admin::BaseController
  before_action :load_manufacturer, except: %i(new index create import)
  before_action :load_list_manufacturer, only: %i(index import)
  before_action :set_search, only: %i(index import)

  def index
    @manufacturers = @q.result.page(params[:page])
      .per Settings.size.size_page_admin
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

  def import
    ActiveRecord::Base.transaction do
      Manufacturer.import params[:file]
      redirect_to admin_manufacturers_url
      flash[:success] = t "successfully_import"
    end
    rescue Exception
      flash[:danger] = t "not_file_import"
      render :index
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

  def destroy
    if @manufacturer.destroy
      flash[:success] = t "manufacturer_delete"
    else
      flash[:danger] = t "cannot_delete_manufacturer"
    end
    redirect_to admin_manufacturers_url
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

  def load_list_manufacturer
    @manufacturers = Manufacturer.select_manufacturer.page(params[:page])
      .per Settings.size.size_page_admin
    return if @manufacturers.present?
    flash[:danger] = t "not_manufacturer"
    redirect_to admin_manufacturers_url
  end

  def set_search
    @q = Manufacturer.ransack params[:q]
  end
end
