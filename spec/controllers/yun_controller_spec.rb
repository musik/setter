#encoding: utf-8
require 'spec_helper'

describe YunController do

  it "company_add" do
    @attr = {
      cpID: 123456,
      cpName: "曲靖某某科技有限公司",
      cpShortName: "曲靖某某科技",
      cpIndustry: 105,
      cpAddressID: 2446,
      cpAddress: "公司详细地址",
      cpPost: 655000,
      cpTel: '0874-3335703',
      cpFax: '0874-3335703',
      cpSite: "http://www.example.com",
      cpEmail: 'test@example.com',
      cpAbout: "本公司简介",
      cpExtend: "扩展信息",
      cpScore: 5,
      cpType: "公司类型",
      cpOpDate: Time.now,
      cpUnionEndDate: Time.now,
      cpState:"公司状态",
      cpMember:"联系人",
      cpMasterBreed:"公司主营品牌",
      cpMasterProduct:"公司主营产品",
      cpCorporation:"公司类型",
      cpMode:"公司模式",
      cpPhone:"18012345678",
      cpLogo:"公司logo地址",
      cpBanner:"公司Banner横幅",
      cpAboutPic:"公司相关图片，用于公司简介",
    }
    #@attr.each do |k,v|
      #v.encode! "GBK","UTF-8" if v.is_a? String
    #end
    client = Savon.client :wsdl=>"http://localhost:3000/yun/wsdl"
    #pp client.operations
    response = client.call(:company_add,message: @attr)
    pp response.body[:company_add_response][:cmd_xml][:cmd_company_url]
    #response = client.call(:company_details,message:{cpID: 123456,cpName: "曲靖某某科技"})
    #pp response.to_hash      
  end

end
