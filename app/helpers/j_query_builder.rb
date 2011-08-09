class JQueryBuilder < ActionView::Template::Handlers::Builder

  attr_accessor :entries

  def initialize(helper_instance)
    @entries         = {}
    @helper_instance = helper_instance
    @controller      = helper_instance.controller
  end

  def tab(options = {}, &block)
    options.reverse_merge!({
        :body  => @helper_instance.capture(&block),
        :title => "none"
      })
    options[:tab_id] =  Digest::MD5.hexdigest("#{options[:title]} #{Time.now}")
    @entries[:tabs]         ||= []
    @entries[:tab_headers]  ||= []
    @entries[:tab_headers] << options.slice(:title, :tab_id)
    @entries[:tabs]        << @controller.render_to_string(:partial => "layouts/tab", :locals   => options)
    nil
  end

  def accord(options = {}, &block)
    options.reverse_merge!({
        :body  => @helper_instance.capture(&block),
        :title => "none"
      })
    options[:tab_id] =  Digest::MD5.hexdigest("#{options[:title]} #{Time.now}")
    @entries[:accordion] ||= []
    @entries[:accordion] << @controller.render_to_string(:partial => "layouts/accord", :locals   => options)
    nil
  end

end
