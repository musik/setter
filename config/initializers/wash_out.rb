require 'wash_out_ext'
def load_wash_actions
  file = File.read("#{Rails.root}/config/tz.yml").gsub('!s','!ruby/symbol')
  YAML.load(file).recursive_symbolize_keys!
end
WASHACTIONS = load_wash_actions
