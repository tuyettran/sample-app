require_relative "boot"

require "rails/all"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.assets.precompile += Ckeditor.assets
    config.assets.initialize_on_precompile = false
    config.assets.precompile += %w( ckeditor/* )
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
  end
end
