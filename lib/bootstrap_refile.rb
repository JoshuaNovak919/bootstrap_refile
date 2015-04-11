require "bootstrap_refile/version"
require "bootstrap_refile/rails/attachment_helper"

module BootstrapRefile
  module Rails
    class Engine < ::Rails::Engine
    	initializer "refile.setup", before: :load_environment_config do
	      ActionView::Base.send(:include, BootstrapRefile::AttachmentHelper)
	      ActionView::Helpers::FormBuilder.send(:include, AttachmentHelper::FormBuilder)
	    end
    end
  end
end
