module JQueryEngine
  Root         = File.expand_path('../..', __FILE__)
  RelativeRoot = Root.gsub(Rails.root, '')
  Javascript   = File.join(RelativeRoot, 'public', 'javascript')
  require "#{Root}/lib/j_query_engine/engine"

end
