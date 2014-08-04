module ApplicationHelper
  
  def ap(path)
    "active" if current_page?(path)
  end
  
end
