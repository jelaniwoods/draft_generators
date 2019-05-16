# frozen_string_literal: true

require "generators/draft/lti/lti_controller_generator"
require "rails/generators/rails/lti/lti_generator"

module Draft
  class LtiGenerator < ::Rails::Generators::ScaffoldGenerator
    remove_hook_for :scaffold_controller
    remove_hook_for :assets

    def generate_controller
      invoke Draft::LtiControllerGenerator
    end
  end
end
