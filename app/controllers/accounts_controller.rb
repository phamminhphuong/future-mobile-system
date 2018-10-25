class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new account_params
    if @user.save
      flash[:success] = t "sign_success"
      redirect_to @account
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit :fullname, :email, :password,
      :password_confirmation, :phone, :address, :image
  end
end
