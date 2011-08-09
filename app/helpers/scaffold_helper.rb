module ScaffoldHelper

  ##
  # Generates an entry for a listing overview
  def entry(model_name, options = {}, &block)
    options.reverse_merge!({
        :model_name => model_name,
        :body       => capture(&block),
        :additional_class => "",
        :dom_id     => ""
      })


    render :template => "layouts/entry", :locals => options
  end

  ##
  # Renders a jQuery Icon with a Lambda-proc
  #
  def icon(dom_class, options = {}, &block)
    dom_class = dom_class_icon_dispatcher(dom_class)

    options.reverse_merge!({
        :class => dom_class,
        :style => "float: left"
      })
    content_tag(:span, (block ? yield : "&nbsp;".html_safe), options)
  end

  ##
  # if you want a delete Button with only a jQuery Default icon, use this to do so
  #
  # =Parameter=
  # *+dom_class+    Icon Class to do do. which icons are supported,
  #                 see dom_class_icon_dispatcher
  # *+url+
  #
  def icon_link(dom_class, url, options = {})
    dom_class = dom_class_icon_dispatcher(dom_class)
    options.reverse_merge!({
        :class => dom_class,
        :style => "float: right"
      })
    link_to("", url, options)
  end


  protected
  def dom_class_icon_dispatcher(dom_class)
    case dom_class
    when :directory then
      "ui-icon ui-icon-folder-collapsed"

    when :add then
      "ui-icon ui-icon-plus"

    when :remove then
      "ui-icon ui-icon-minus"

    else
      "icon icon-#{dom_class.to_s}"
    end

  end
end

