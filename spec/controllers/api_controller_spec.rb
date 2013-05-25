#encoding: utf-8
require 'spec_helper'

describe ApiController do
  def args(xml)
    {:strToken=>'98fbb9a2bf7f7c8014f836c366019f84',:strXmlKeyValue=>xml}
  end

  it "error_output" do
    #pp ApiController.new.error_output 404,"fail"
  end
  it "company_add" do
    #xml = File.read("#{Rails.root}/db/test/company_add_instance.xml").encode("UTF-8",'GBK')
    xml = File.read("#{Rails.root}/db/test/company_add_instance.xml")
    xml = File.read("#{Rails.root}/tmp/1.xml")
    xml = "<XMLData><cpID>68416</cpID><cpName>河南省四通锅炉有限公司</cpName><cpShortName>四通锅炉</cpShortName><cpIndustry>116</cpIndustry>   <cpAddressID>838</cpAddressID><cpAddress>河南省周口市太康县工业区</cpAddress><cpPost>461400</cpPost><cpTel>0394-6776179</cpTel><cpFax>0394-6776179</cpFax><cpSite>http://www.4000588865.com</cpSite><cpEmail>939153452@qq.com</cpEmail><cpAbout>&lt;p&gt;&amp;nbsp; 河南四通锅炉有限公司是国家定点生产B级锅炉制造企业,河南四通工业锅炉工业园紧临311国道与周商高速公路,交通便利,辐射深远.河南河南四通工业锅炉拥有完善的质保体系与先进的生产工艺;科&lt;/p&gt;\n&lt;p&gt;学严谨的管理模式和优良的售前,售中,售后服务;深睿德治的企业理念和典雅的企业文化.公司在业界可谓:成绩斐然,有口皆碑.也正是'四通锅炉进万家,安全温暖你我他'&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; 河南河南四通工业锅炉产品主要有蒸汽锅炉、燃煤锅炉、燃油锅炉、燃气锅炉、热水锅炉、电热蒸汽锅炉、蒸压釜、河南太康锅炉，煤气发生炉、节能环保型半煤气蒸汽锅炉、燃煤蒸汽锅炉、&lt;/p&gt;\n&lt;p&gt;WNS系列卧式燃油(气)承压热水锅炉、 燃气蒸汽锅炉、煤矿专用锅炉、立式蒸汽锅炉、节能环保锅炉、全自动燃油(气)卧式常压热水锅炉、有机热载体炉；垃圾焚烧炉；高、中、低&lt;/p&gt;\n&lt;p&gt;温热风炉等13个系列100多个规格型号。&lt;/p&gt;\n&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; 河南四通工业锅炉拥有雄厚的开发实力,专业的开发工程师采用CAD电脑设计,油泥造型和快速成型技术,使用光学三维扫描仪从事数据采集工程,应用辅助产品外形设计,并拥有完善的检验分析检测&lt;/p&gt;\n&lt;p&gt;设备及手段,从设计制造及每道工序都让人充分领略前沿科技的无限风光.为不断开发适应市场的更新产品提供了根本保证. &amp;nbsp;&lt;/p&gt;\n&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;河南四通工业锅炉的宗旨&amp;ldquo;做百年企业、服务社会&amp;rdquo;的发展目标，秉承&amp;ldquo;品质为本、诚信天下的企业理念，全力打造供热精品，把为客户创造最大价值、提供全过程、全方位、全天候的服务作&lt;/p&gt;\n&lt;p&gt;为公司的崇高使命。&lt;/p&gt;\n&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;河南河南四通工业锅炉坚持科技为先导,人才为支撑,质量为保证,服务不断超前的宗旨,并遵循'出厂一台锅炉,交一位朋友,建一项示范工程,开发一片市场'的经营理念,24小时的专家值守电话和&lt;/p&gt;\n&lt;p&gt;电脑网络服务,随时提供精诚的帮助.不断赢得更多市场份额及用户的信赖,为'河南四通工业锅炉'走向国际化奠定了基础. 河南四通锅炉有限公司官方网站：www.4000588865.com 联系方式： 13526295265 QQ：939153452&lt;/p&gt;</cpAbout><cpScore>1</cpScore><cpType>1</cpType><cpOpDate>2013/5/11 12:00:22</cpOpDate><cpUnionEndDate>2013/5/11 12:01:28</cpUnionEndDate><cpState>1</cpState><cpMember>田义鹏</cpMember><cpMasterBreed>四通锅炉</cpMasterBreed><cpMasterProduct>燃气锅炉|蒸汽锅炉|燃煤锅炉|免验收锅炉</cpMasterProduct><cpCorporation>民营公司</cpCorporation><cpMode>4</cpMode> <cpPhone>13526295265</cpPhone> <cpLogo>http://img1.dns4.cn/pic/68416/20130511111515_7628.jpg</cpLogo><cpBanner>http://c1.dns4.cn/images/backstage-logo.jpg</cpBanner><cpAboutPic>http://img1.dns4.cn/pic/68416/20130511113124_0721.jpg</cpAboutPic></XMLData>"
    client = Savon.client :wsdl=>"http://localhost:2999/api/wsdl"
    #client = Savon.client :wsdl=>"http://ws.ynlp.com/api/wsdl"
    response = client.call(:company_add,message: args(xml))
    #pp response.body#[:company_add_response][:cms_state]
    pp Hash.from_xml(response.to_hash[:company_add_response][:value])
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
