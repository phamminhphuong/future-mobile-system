class AccountsController < ApplicationController
  before_action :logged_in_account, except: %i(show new create)
  before_action :correct_account, only: %i(edit update)
  before_action :load_account, except: %i(index new create)

  def new
    @account = Account.new
  end

  def create
    @account = Account.new account_params
    if @account.save
      log_in @account
      flash[:success] = t "sign_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @account.update_attributes account_params
      flash[:success] = t "update_success"
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:fullname, :email, :password,
      :password_confirmation, :phone, :address).merge account_type: :member
  end

  def logged_in_account
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_url
  end

  def load_account
    @account = Account.find_by id: params[:id]
    return if @account.present?
    flash[:danger] = t "sign_up_not_found"
    redirect_to signup_path
  end

  def correct_account
    @account = Account.find_by id: params[:id]
    redirect_to root_url unless @current_account == current_account
  end
end
