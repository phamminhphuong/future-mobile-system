class Admin::XmlController < Admin::BaseController
  def index
    @order_details = OrderDetail.all
    respond_to do |format|
      format.html
      format.xls {send_data @order_details.to_xls(col_sep: "\t")}
    end
  end
end
