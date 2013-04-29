class YunController < ApplicationController
  include WashOut::SOAP
  include WashOutExt
  soap_load_actions
  def company_add
    #@results = post action_name,params    
    @results = {
      :CmdState=>1,
      :CmdXml=>{
        :CmdCompanyUrl => @response.body,
      }
    }
    render :soap=>@results
  end
  def company_details
    @results = {
      :CmdState=>1,
      :CmdXml=>{
        :cpID => 123456
      }
    }
    render :soap=>@results
  end
  def company_list
  end
  def company_modify
  end
  def company_modify_status
  end
  soap_action "testaction",
      :args => Company
  def testaction
  end
  before_filter :dump_parameters,:remote_post,:except=>%(_generate_wsdl)
  private
  def remote_post
    url = "http://www.ynshangji.com/api/"
    #url = "http://localhost/wsdl.php"
    @response = Typhoeus::Request.post "#{url}#{action_name}.asp",:params=> params
    Rails.logger.debug @response.inspect
    logger.debug @response.body
  end
  def dump_parameters
    Rails.logger.debug params.inspect
  end
end
