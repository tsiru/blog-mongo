module BootstrapHelper
  def bootstrap_flash_class(level)
    case level
    when :notice  then :"alert alert-info"
    when :success then :"alert alert-success"
    when :error   then :"alert alert-danger"
    when :alert   then :"alert alert-warning"
    end
  end

  def icon(*icons, text)
    icons.map!{ |icon| "fa-#{icon}" }
    icons << :fa << :'fa-fw'
    tag = content_tag(:i, nil, class: icons.join(' '))
    "#{tag} #{text}".html_safe
  end

  def content_for_message(level, &block)
    content_tag(:div, nil, class: bootstrap_flash_class(level), &block)
  end
end
