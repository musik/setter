class PostToNdrc
  @queue = "ndrc"
  def self.perform args
    @debug = args.has_key? "debug"
    if(args.key?("strXmlKeyValue"))
      xml_data = Hash.from_xml(args.delete("strXmlKeyValue"))["XMLData"]
      %w(cpAbout bsContent nsContent wsSingleJS wsSingleIcons wsListJS).each do |k|
        xml_data[k] = CGI.escape(xml_data[k]) if xml_data.has_key?(k)
      end
      args[:data] =  xml_data
    else
      nrgs={
        strToken: args.delete("strToken"),
        "remote_action"=> args.delete("remote_action")
      }
      nrgs[:data] = args
      args = nrgs
    end
    #pp ["in queue",args]
    host = @debug ? "http://localhost:4001/" : "http://www.ndrc.ac.cn/"
    @response = Typhoeus::Request.post(host + args.delete("remote_action") +".json",:params=> args)
    if @response.success?
      Rails.logger.info "ndrc posted;"
    else
      Rails.logger.info "ndrc posted fail;"
    end
  end
end
