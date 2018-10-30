class Admin::CommentsController < Admin::BaseController
  before_action :load_comment, only: %i(destroy)

  def destroy
    product_id = @comment.product_id
    if @comment.destroy
      flash[:success] = t "successfully_delete"
    else
      flash[:danger] = t "cannot_delete_comment"
    end
    redirect_to admin_product_url(product_id)
  end

  private

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment.present?
    flash[:danger] = t "not_comment"
    redirect_to admin_product_url(product_id)
  end
end
