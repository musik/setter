#encoding: utf-8
require 'spec_helper'

describe YunController do

  it "returns http success" do
    client = Savon.client :wsdl=>"http://localhost:3000/yun/wsdl"
    #client = Savon.client :wsdl=>"http://localhost:4001/ws/wsdl"
    pp client.operations
    response = client.call(:company_add,message:{cpID: 123456,cpName: "曲靖某某科技"})
    pp response.to_hash      
  end

end
