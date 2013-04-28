class YunController < ApplicationController
  include WashOut::SOAP
  include WashOutExt
  soap_load_actions
  #soap_action "company_add",
    #:args=>{:cpID=>:string,:cpName=>:string},
    #:return=>{:CmdState=>:integer}
  def company_add
    render :soap=>{:CmdState=>1}
  end
  def company_details
  end
  def company_list
  end
  def company_modify
  end
  def company_modify_status
  end
  before_filter :dump_parameters
  private
  def dump_parameters
    Rails.logger.debug params.inspect
  end
end
