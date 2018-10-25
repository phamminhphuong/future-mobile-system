class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: %i(new index create)

  def index
    @categories = Category.select_category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "successfully_create"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "successfully_update"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category.present?
    flash[:danger] = t "not_category"
    redirect_to admin_categories_url
  end
end
