module WashOutExt
  extend ActiveSupport::Concern
  module ClassMethods
    def soap_load_actions
      #actions = Rails.env.production? ? WASHACTIONS : load_wash_actions
      actions = WASHACTIONS
      actions.each do |k,v|
        v[:return] = {:CmdState=> :integer} if !v.has_key? :return
        soap_action k,v
      end
    end
  end
end
class Hash
  def recursive_symbolize_keys!
    symbolize_keys!
    values.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    values.select{|v| v.is_a?(Array) }.flatten.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    self
  end
end
