#encoding: utf-8
require 'spec_helper'

describe YunController do

  it "company_add" do
    client = Savon.client :wsdl=>"http://localhost:3000/yun/wsdl"
    #pp client.operations
    response = client.call(:company_add,message:{cpID: 123456,cpName: "曲靖某某科技"})
    pp response.body      
    #response = client.call(:company_details,message:{cpID: 123456,cpName: "曲靖某某科技"})
    #pp response.to_hash      
  end

end
