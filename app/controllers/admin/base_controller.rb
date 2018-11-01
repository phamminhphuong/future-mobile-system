class Admin::BaseController < ApplicationController
  layout "admin/layouts/application"
  before_action :admin_account

  def admin_account
    return if current_account &&  current_account.admin?
    flash[:danger] = t "this_place_not_allowed_you"
    redirect_to root_path
  end
end
