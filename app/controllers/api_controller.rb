#encoding: utf-8
class ApiController < ApplicationController
  include WashOut::SOAP
  include ApiHelper
  #include WashOutExt
  WASHACTIONS.each do |name|
    soap_action name,
        :args=>{:strToken=>:string,:strXmlKeyValue=>:string},
        :return=>:string
  end
  def action_missing name
    render_soap
  end
  before_filter :dump_parameters,:remote_post,:except=>[:_generate_wsdl]
  private
  def encode_params args,from,to
    args.each do |k,v|
      v.encode! to,from if v.is_a? String
    end
  end
  def render_soap
    render :soap => @xml_data
  end
  def remote_post
    #next if %w(_generate_wsdl).include? action_name
    url = "http://tz.ynshangji.com/api/"
    args = escaped_params
    xml_data = Hash.from_xml(args.delete("strXmlKeyValue"))["XMLData"] rescue nil
    if xml_data.nil?
      @xml_data = error_output(0,'xml_data can\'t be empty')
      return
    end
    args.merge! xml_data
    logger.debug args
    begin
      args = encode_params(args,'utf-8','gbk')
    rescue Exception=>e
      @xml_data = error_output(0,e.message)
      return
    end
    @response = Typhoeus::Request.post "#{url}#{action_name}.asp",:params=> args
    #logger.info @response.inspect
    if @response.success?
      xml = @response.body.encode('utf-8','gbk').sub('gb2312','utf-8')
      @xml_data = xml 
    else
      @xml_data = error_output(@response.code,"请求失败 #{@response.curl_error_message}")
    end
    #logger.info @xml_data
  end
  def escaped_params
    @_escaped_params ||= request.params["Envelope"]["Body"].first[1]
  end
  def dump_parameters
    Rails.logger.debug params.inspect
  end
end
