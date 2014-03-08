module ApiHelper
  def error_output level,message
    {CmdState: 2,CmdErrorLevel: level,CmdTips: message }.to_xml :root=> "XMLData"
  end
  def encode_params args,from,to
    args.each do |k,v|
      v.encode! to,from,:invalid=>:replace,:undef=>:replace,:replace=>'?' if v.is_a? String
    end
  end
  def parse_args encoding = ''
    hash = Hash[request.params["Envelope"]["Body"][action_name]]
    hash2 = Hash.from_xml(hash.delete("strXmlKeyValue"))["XMLData"]
    hash.merge! hash2
    hash = encode_params(hash,'utf-8',encoding) if encoding.present?
    %w(cpAbout bsContent nsContent wsSingleJS wsSingleIcons wsListJS).each do |k|
      hash[k] = CGI.escape(hash[k]) if hash.key?(k)
    end
    hash
  end
end
