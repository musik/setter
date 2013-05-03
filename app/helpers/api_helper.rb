module ApiHelper
  def error_output level,message
    {CmdState: 2,CmdErrorLevel: level,CmdTips: message }.to_xml :root=> "XMLData"
  end
end
