class SessionsController < ApplicationController
  def new; end

  def create
    account = Account.find_by email: params[:session][:email].downcase
    if account&.authenticate params[:session][:password]
      log_in account
      unless current_account.admin?
        flash[:success] = t "login_success"
        redirect_to root_url and return
      end
      redirect_to admin_dasboard_index_url
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
