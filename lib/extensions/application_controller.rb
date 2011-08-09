module Extensions::ApplicationController
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
end

#ApplicationController.send(:include, Extensions::ApplicationController)
#ApplicationController.send(:helper_method, :mobile_device?)

