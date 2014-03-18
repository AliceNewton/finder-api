$LOAD_PATH.unshift(File.expand_path("../../", File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.expand_path("../../lib/", File.dirname(__FILE__)))

require "rack/test"
require "finder_api"
require "features/support/schema_helpers"
require 'byebug'

module SinatraTestIntegration
  include Rack::Test::Methods

  def app
    FinderApi.new
  end
end

World(SinatraTestIntegration)
World(SchemaHelpers)
