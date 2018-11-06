class CommentsController < ApplicationController
  before_action :find_product
  before_action :find_comment, except: %i(new create)
  before_action :comment_owner, only: %i(destroy update edit)
  before_action :authenticate_account

  def create
    @comment = @product.comments.create comment_params
    @comment.account_id = current_account.id
    @comment.save
    @comments = Comment.where(product_id: @product).show_comment_desc
      .page(params[:page])
      .per Settings.size.picture_size
    if @comment.save
      respond_to {|format| format.js}
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @comment.update comment_params
      respond_to {|format| format.js}
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_error"
    end
    redirect_to product_path @product
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def find_product
    @product = Product.find params[:product_id]
    return unless @product.nil?
    flash[:danger] = t "product_not_found"
    redirect_to product_path @product
  end

  def find_comment
    @comment = @product.comments.find params[:id]
    return unless @comment.nil?
    flash[:danger] = t "comment_not_found"
    redirect_to product_path @product
  end

  def comment_owner
    return if current_account.id == @comment.account.id
    flash[:warning] = t "not_pass"
    redirect_to @product
  end

  def authenticate_account
    return if current_account.present?
    flash[:danger] = t "sign_up_not_found"
    redirect_to login_url
  end
end
