module ApplicationHelper
  def noun_project_icon(name, options = {})
    file_path = "#{name}.png"
    options[:class] ||= ""
    options[:class] << " noun-project-icon"
    options[:alt] ||= name.to_s.humanize
    options[:width] ||= "32px" # Set the width of the icon
    options[:height] ||= "32px"
    image_tag(file_path, options)
  end
end
