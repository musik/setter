module WashOutExt
  extend ActiveSupport::Concern
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    attr_accessor :actions
    def load_wash_actions
      @action ||=
        begin
          file = File.read("#{Rails.root}/config/tz.yml").gsub('!s','!ruby/symbol')
          actions = YAML.load(file).recursive_symbolize_keys!
          actions.each do |k,v|
            v[:return] ||= {}
            v[:return].each do |rk,val|
              v[:return][rk] = parse_return(val)
            end
            v[:return] = {
              :CmdState=> :integer,
              :CmdErrorLevel=> :string,
              :CmdTips=>:string
            }.merge v[:return]
            if v[:args].is_a? String
              v[:args] = eval(v[:args]).send :wash_out_param_map
            end
          end
          #pp actions
          actions
        end
    end
    def parse_return val
      return nil if val.nil?
      if val.is_a? String
        eval(val)
      elsif val.is_a? Array
        val.collect{|v|
          eval(v) if v.is_a? String
        }
      end
    end
    def load config_file
      @actions = YAML.load_file config_file
    end
    def soap_load_actions
      actions = Rails.env.production? ? WASHACTIONS : load_wash_actions
      #actions = load_wash_actions
      actions.each do |k,v|
        soap_action k.to_s,v
      end
    end
  end
end
class WashOutExtIns
  include WashOutExt
end
class Hash
  def recursive_symbolize_keys!
    symbolize_keys!
    values.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    values.select{|v| v.is_a?(Array) }.flatten.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    self
  end
end
#WashOutExt.load "#{Rails.root}/config/tz_actions.yml"
