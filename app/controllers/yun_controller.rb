#encoding: utf-8
class YunController < ApplicationController
  include WashOut::SOAP
  include WashOutExt
  soap_load_actions
  def action_missing name
    #logger.debug name
    render_soap
  end
  before_filter :dump_parameters,:remote_post,:except=>[:_generate_wsdl, :testaction]
  private
  def encode_params args,from,to
    args.each do |k,v|
      v.encode! to,from if v.is_a? String
    end
  end
  def error_output level,message
    {CmdState: 2,CmdErrorLevel: level,CmdTips: message }
  end
  def render_soap
    render :soap => @xml_data
  end
  def remote_post
    #next if %w(_generate_wsdl).include? action_name
    url = "http://www.ynshangji.com/api/"
    args = encode_params(params,'utf-8','gbk')
    @response = Typhoeus::Request.post "#{url}#{action_name}.asp",:params=> args
    if @response.success?
      xml = @response.body.encode('utf-8','gbk').sub('gb2312','utf-8')
      xml = File.read("#{Rails.root}/db/test/company_add.xml")
      @xml_data = Hash.from_xml(xml)["XMLData"]
    else
      logger.debug @response.inspect
      @xml_data = error_output(@response.code,'请求失败')
    end
    logger.info @xml_data
  end
  def dump_parameters
    Rails.logger.debug params.inspect
  end
end
