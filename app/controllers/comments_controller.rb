class CommentsController < ApplicationController
  before_action :find_product
  before_action :find_comment, except: %i(new create)
  before_action :comment_owner, only: %i(destroy update edit)
  before_action :authenticate_account!, only: %i(create)

  def new
    @comment = Comment.new
  end

  def create
    @comment = @product.comments.create comment_params
    @comment.account_id = current_account.id
    @comment.save
    if @comment.save
      flash[:success] = t "you_are_commented"
      redirect_to product_path @product
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update comment_params
      flash[:success] = t "update_comment_succsess"
      redirect_to product_path @product
    else
      render :edit
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
    return unless current_account.id == @comment.account.id
    flash[:warning] = t "not_pass"
    redirect_to @product
  end
end
