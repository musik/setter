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
            v[:return] = {
              :CmdState=> :integer,
              :CmdErrorLevel=> :string,
              :CmdTips=>:string
            }.merge v[:return]
            if v[:return].has_key? :CmdXml
              v[:return][:CmdXml] = eval(v[:return][:CmdXml])
            end
            if v[:args].is_a? String
              v[:args] = eval(v[:args]).send :wash_out_param_map
            end
          end
          actions
        end
    end
    def soap_load_actions
      actions = Rails.env.production? ? WASHACTIONS : load_wash_actions
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
