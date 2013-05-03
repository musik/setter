#require 'wash_out_ext'
#
#WASHACTIONS = WashOutExtIns.load_wash_actions 
WASHACTIONS = YAML.load_file "#{Rails.root}/config/tz_actions.yml"
