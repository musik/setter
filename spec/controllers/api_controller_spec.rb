#encoding: utf-8
require 'spec_helper'

describe ApiController do
  def args(xml)
    {:strToken=>'testtoken',:strXmlKeyValue=>xml}
  end

  it "error_output" do
    #pp ApiController.new.error_output 404,"fail"
  end
  it "company_add" do
    #xml = File.read("#{Rails.root}/db/test/company_add_instance.xml").encode("UTF-8",'GBK')
    xml = File.read("#{Rails.root}/db/test/company_add_instance.xml")
    client = Savon.client :wsdl=>"http://localhost:2999/api/wsdl"
    #client = Savon.client :wsdl=>"http://ws.ynlp.com/api/wsdl"
    response = client.call(:company_add,message: args(xml))
    pp response.body#[:company_add_response][:cms_state]
  end
  it "company list" do
    #@attr = {
      #cpIndustry: 105
    #}
    #client = Savon.client :wsdl=>"http://localhost:3000/yun/wsdl"
    #response = client.call(:company_list,message: @attr)
    #pp response.body#[:company_add_response][:cms_state]

  end
end
