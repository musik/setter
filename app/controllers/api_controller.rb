#encoding: utf-8
class ApiController < ApplicationController
  include WashOut::SOAP
  include ApiHelper
  include ActionView::Helpers::SanitizeHelper
  #include WashOutExt
  WASHACTIONS.each do |name|
    soap_action name,
        :args=>{:strToken=>:string,:strXmlKeyValue=>:string},
        :return=>:string
  end
  def action_missing name
    render_soap
  end
  before_filter :dump_parameters,:remote_post,:async_post_to_ndrc,:except=>[:_generate_wsdl]
  private
  def async_post_to_ndrc
    action_maps = {
      "CompanyAdd"=> "qiye",
      #"BuySellAdd"=> "sell"
    }
    remote_action = action_maps[action_name]
    @args = request.params["Envelope"]["Body"][action_name]
    logger.debug @args
    Resque.enqueue(PostToNdrc,@args) if remote_action.present?
  end
  def encode_params args,from,to
    args.each do |k,v|
      v.encode! to,from,:invalid=>:replace,:undef=>:replace,:replace=>'?' if v.is_a? String
    end
  end
  def render_soap
    render :soap => @xml_data
  end
  def parse_subdomain
    sites = {
      'ws'=>'tz.ynshangji.com',
      'zs'=>'tz.zhaoshang100.com'
    }
    @url = sites.has_key?(request.subdomain) ? sites[request.subdomain] : sites['ws']
    logger.info "SITE: #{@url}"
  end
  def remote_post
    parse_subdomain
    #next if %w(_generate_wsdl).include? action_name
    url = "http://#{@url}/api/"
    logger.debug url
    @args = escaped_params
    @debug = (@args.has_key? "debug" and @args["debug"] == "true")
    begin
      xml_data = Hash.from_xml(@args.delete("strXmlKeyValue"))["XMLData"]
      @args.merge! xml_data
      @args = encode_params(@args,'utf-8','gbk')
      %w(cpAbout bsContent nsContent wsSingleJS wsSingleIcons wsListJS).each do |k|
        @args[k] = CGI.escape(@args[k]) if @args.has_key?(k)
      end
    rescue Exception=>e
      logger.info "Request not made"
      @xml_data = error_output(0,e.message)
      return
    end
    logger.debug @args
    url = @debug ? "http://vcap.me:3000/test" : "#{url}#{action_name}.asp"
    @response = Typhoeus::Request.post url,:params=> @args
    logger.info @response.inspect
    if @response.success?
      @xml_data = @response.body
      @xml_data = @xml_data.encode('utf-8','gbk',:invalid=>:replace,:undef=>:replace,:replace=>'?').sub('gb2312','utf-8')
      if @xml_data.match('strToken is wrong').present?
        @xml_data = error_output(403,'strToken is wrong')
      end
    else
      message = @response.curl_error_message.sub('No error','') rescue ''
      (message += @response.body.encode('utf-8','gbk',:invalid=>:replace,:undef=>:replace,:replace=>'?')) unless @response.body.nil?
      message = strip_tags(message)
      @xml_data = error_output(@response.code,"返回码!=200.Error message:#{message}")
      logger.info @xml_data
    end
    #logger.info @xml_data
  end
  def escaped_params
    request.params["Envelope"]["Body"][action_name]
  end
  def dump_parameters
    #Rails.logger.debug params.inspect
  end
end
