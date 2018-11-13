class SendEmailJob < ApplicationJob
  queue_as :default

  def perform params
    @account = params[:account]
    @order = params[:order]
    @price_total = params[:total]
    AccountMailer.send_email_order(@account, @order, @price_total).deliver_later
  end
end
