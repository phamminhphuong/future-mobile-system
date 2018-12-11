class Admin::ManufacturersController < Admin::BaseController
  before_action :load_manufacturer, except: %i(new index create import softdelete harddelete restore)
  before_action :load_list_manufacturer, only: %i(index import destroy)
  before_action :set_search, only: %i(index import destroy)
  before_action :find_manufacturer, only: %i(harddelete restore)

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
    begin
      @manufacturer.destroy!
      flash[:success] = t "manufacturer_delete"
    rescue
      flash[:danger] = t "cannot_delete_manufacturer"
    end
    redirect_to admin_manufacturers_url
  end

  def softdelete
    @manufacturers = Manufacturer.only_deleted.page(params[:page])
      .per Settings.size.size_page_admin
  end

  def harddelete
    if @manufacturer.really_destroy!
      flash[:success] = "Delete success"
      redirect_to admin_manufacturers_path
    else
      flash[:danger] = "Delete error"
      render :sodtdelete
    end
  end

  def restore
    if @manufacturer.restore(:recursive => true)
      flash[:success] = "Restore success"
      redirect_to admin_manufacturers_path
    else
      flash[:danger] = "Restore error"
      render :sodtdelete
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

  def find_manufacturer
    @manufacturer =  Manufacturer.with_deleted.find_by id: params[:id]
    return if @manufacturer.present?
    flash[:danger] = t "not_manufacturer"
    redirect_to admin_manufacturers_url
  end

end
