class SessionsController < ApplicationController
  def new; end

  def create
    account = Account.find_by email: params[:session][:email].downcase
    if account&.authenticate params[:session][:password]
      log_in account
      redirect_to root_url
      flash[:success] = t "login_success"
    else
      flash.now[:danger] = t "invalid_email_pass"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
