class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new account_params
    if @account.save
      flash[:success] = t "sign_success"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(:fullname, :email, :password,
      :password_confirmation, :phone, :address).merge(account_type: :member)
  end
end
