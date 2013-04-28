class YunController < ApplicationController
  include WashOut::SOAP
  include WashOutExt
  soap_load_actions
  def company_add
  end
  def company_details
  end
  def company_list
  end
  def company_modify
  end
  def company_modify_status
  end
end
