
module JQueryHelper

  def render_flash
    render :template => "layouts/flash"
  end

  ##
  # Generates a Link which is styled as an Button
  def link_button(*args)
    link_to *collect_additional_json_options(*args)
  end

  ##
  # Generates a styled Button-element
  def ui_button(*args)
    content_tag :button , * collect_additional_json_options(*args)
  end

  def button_group(options = {}, &block )
    content_tag :span, capture(&block),
      :"data-role" => "controlgroup",
      :"data-type" => "horizontal",
      :class       => "button-set"
  end

  ##
  # Generates a Block, which is Styled as jQueryUi-Widget
  #
  def ui_widget(options = {}, &block)
    content_tag :div, :id => "toolbar", :class =>"ui-widget-header ui-corner-all", :"data-inline" => true do
      block ? yield : ""
    end
  end


  ##
  # Display a jQueryUi Dialog
  # See jQueryUi Api-Doc to see which Options you can set through :data
  #
  def dialog(options = {}, &block)
    options.reverse_merge!({
        :title => "none",
        :params => "{}",
        :body  => capture(&block)
      })
    options[:params] = options[:params].to_json unless options[:params].is_a?(String)
    render :template => "layouts/dialog", :locals   => options
  end

  def tabbing(options = {})
    raise ArgumentError, "Missing block" unless block_given?

    builder = JQueryBuilder.new(self)
    yield(builder)
    render :template => "layouts/tabs",  :locals   => {
      :tab_headers => builder.entries[:tab_headers],
      :tabs        => builder.entries[:tabs]
    }
  end

  def accordion(options = {})
    raise ArgumentError, "Missing block" unless block_given?

    builder = JQueryBuilder.new(self)
    yield(builder)
    render :template => "layouts/accordion",  :locals   => {
      :body => builder.entries[:accordion]
    }
  end

  def progressbar(options = {})
    options.reverse_merge!({:percent => "0"})
    render :template => "layouts/progressbar", :locals   => options
  end

  protected

  def collect_additional_json_options(*args)
    html = args.pop
    if html.is_a?(Hash)
      html = dom_class_button_dispatcher(html)
      html[:data] = html[:data].to_json unless html[:data].is_a?(String)
      args.push(html)


    else
      args.push(html)
      args <<  {:"data-role" => "button"}
    end
    return args
  end


  ##
  # Dispatches Icon-Settigns to jQuery-UI and jQuery-mobile Compatible Data-Tags
  # so they could be displayed in both correct
  #
  def dom_class_button_dispatcher(attributes = {})
    attributes.reverse_merge!({
      :"data-role" => "button",
      :data        => {}
    })

    case attributes[:icon]
    when "prev" then
      attributes[:data][:icons] = { :primary => "ui-icon-seek-start" }
      attributes[:"data-icon"]  = "arrow-l"
      attributes[:"data-theme"] = "c"

    when "next" then
      attributes[:data][:icons] = { :primary => "ui-icon-seek-end" }
      attributes[:"data-icon"]  = "arrow-r"
      attributes[:"data-theme"] = "c"

    when "play" then
      attributes[:data][:icons] = { :primary => "ui-icon-play" }
      attributes[:"data-icon"]  = "arrow-r"
      attributes[:"data-theme"] = "b"

    when "random" then
      attributes[:data][:icons] = { :primary => "ui-icon-shuffle" }
      attributes[:"data-icon"]  = ""
      attributes[:"data-theme"] = "e"

    when "no_random" then
      attributes[:data][:icons] = { :primary => "ui-icon-transfer-e-w" }
      attributes[:"data-icon"]  = ""
      attributes[:"data-theme"] = "c"

    when "repeat" then
      attributes[:data][:icons] = { :primary => "ui-icon-refresh" }
      attributes[:"data-icon"]  = "forward"
      attributes[:"data-theme"] = "e"

    when "no_repeat" then
      attributes[:data][:icons] = { :primary => "ui-icon-arrowreturn-1-e" }
      attributes[:"data-icon"]  = ""
      attributes[:"data-theme"] = "c"

    else
      unless attributes[:icon].nil?
        attributes[:data][:icons] = { :primary => "ui-icon-#{attributes[:icon]}" }
        attributes[:"data-icon"]  = attributes[:icon]
        attributes[:"data-theme"] = "b"
      end
    end

    return attributes
  end
end

