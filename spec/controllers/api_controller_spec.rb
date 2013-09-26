#encoding: utf-8
require 'spec_helper'

describe ApiController do
  def args(xml,debug=true)
    {:strToken=>'98fbb9a2bf7f7c8014f836c366019f84',:strXmlKeyValue=>xml,:debug=>debug}
  end

  it "error_output" do
    #pp ApiController.new.error_output 404,"fail"
  end
  it "company_add" do
    #xml = File.read("#{Rails.root}/db/test/company_add_instance.xml").encode("UTF-8",'GBK')
    xml = File.read("#{Rails.root}/db/test/company_add_instance.xml")
    xml = File.read("#{Rails.root}/tmp/1.xml")
    client = Savon.client :wsdl=>"http://ws.lvh.me:2999/api/wsdl"
    #client = Savon.client :wsdl=>"http://zs.ynlp.com/api/wsdl"
    #response = client.call(:company_add,message: args(xml))
    #pp response.body#[:company_add_response][:cms_state]
    #pp Hash.from_xml(response.to_hash[:company_add_response][:value])
  end
  it "buyselladd" do
    xml = File.read("#{Rails.root}/db/test/buy_sell_add.xml")
    client = Savon.client :wsdl=>"http://ws.lvh.me:2999/api/wsdl"
    #client = Savon.client :wsdl=>"http://zs.ynlp.com/api/wsdl"
    response = client.call(:buy_sell_add,message: args(xml))
    pp response.body#[:company_add_response][:cms_state]
    pp Hash.from_xml(response.to_hash[:buy_sell_add_response][:value]) rescue nil

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
