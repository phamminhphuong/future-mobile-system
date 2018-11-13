class AccountMailer < ApplicationMailer
  def send_email_order current_account, order, price_total
    @account = current_account
    @order_details = order.order_details
    @price_total = price_total
    mail to: @account.email, subject: t("information_buy_product")
  end
end
