module ApplicationHelper
  def sidebar_link_item(name, path, options = {})
    class_name = 'channel'
    class_name << ' active' if current_page?(path)

    content_tag :li, class:class_name do
      link_to name, path, options
    end
  end
end
