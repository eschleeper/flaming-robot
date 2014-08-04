module CrittersHelper
  
    # Returns a dynamic path based on the provided parameters
  def sti_critter_path(type = "critter", critter = nil, action = nil)
    send "#{format_sti(action, type, critter)}_path", critter
  end
  
  def format_sti(action, type, critter)
    action || critter ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end
  
  def format_action(action)
    action ? "#{action}_" : ""
  end
  
end
