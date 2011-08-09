require 'rails'

class JQueryEngine::Engine < Rails::Engine

#    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery =>(
      #%w(jquery-1.6.1.min).map { |n| "#{JQueryEngine::Javascript}/jquery/#{n}" } +
      #%w(jquery_engine)
    #)
    #ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery_ui =>(
      #%w(jquery-ui-1.8.13.custom.min jquery.ui.selectmenu).map { |n| "#{JQueryEngine::Javascript}/jquery/#{n}" } +
      #%w(jquery_engine_ui)
    #)
    #ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery_mobile =>(
      #%w(jquery.mobile-1.0a4.1.js).map { |n| "#{JQueryEngine::Javascript}/jquery/#{n}" } +
      #%w(jquery_engine_mobile)
    #)
    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery =>(
      %w(jquery-1.6.1).map { |n| "jquery/#{n}" } +
      %w(jquery_engine)
    )
    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery_ui =>(
      %w(jquery-ui-1.8.13.custom.min jquery.ui.selectmenu).map { |n| "jquery/#{n}" } +
      %w(jquery_engine_ui)
    )
    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery_mobile =>(
      %w(jquery.mobile-1.0a4.1.js).map { |n| "jquery/#{n}" } +
      %w(jquery_engine_mobile)
    )


    # Config defaults
    config.widget_factory_name = "jQuery"
    config.mount_at = '/'

   
    # Load rake tasks
    rake_tasks do
      load File.join(File.dirname(__FILE__), 'rails/railties/tasks.rake')
    end

    # Check the gem config
    initializer "check config" do |app|
      # make sure mount_at ends with trailing slash
      config.mount_at += '/'  unless config.mount_at.last == '/'
    end 

    #initializer "static assets", :after =>:build_middleware_stack  do |app|
    initializer "static assets"  do |app|
      app.middleware.use(::ActionDispatch::Static, "#{root}/public")
#      middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
    end

end
