class Admin::ImagesController < Admin::BaseController
  before_action :load_image, only: %i(destroy)

  def destroy
    product_id = @image.product_id
    if @image.destroy
      flash[:success] = t "successfully_delete"
    else
      flash[:danger] = t "cannot_delete_image"
    end
    redirect_to admin_product_url(product_id)
  end

  private

  def load_image
    @image = Image.find_by id: params[:id]
    return if @image.present?
    flash[:danger] = t "not_image"
    redirect_to admin_product_url(product_id)
  end
end
