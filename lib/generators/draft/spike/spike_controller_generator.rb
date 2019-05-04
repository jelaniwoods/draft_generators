# frozen_string_literal: true

require "generators/draft/spike/spike_erb_generator"
require "rails/generators/rails/spike_controller/spike_controller_generator"

module Draft
  class SpikeControllerGenerator < ::Rails::Generators::ScaffoldControllerGenerator
    source_root Rails::Generators::ScaffoldControllerGenerator.source_root

    remove_hook_for :template_engine

    def generate_views
      invoke Draft::SpikeErbGenerator
    end
  end
end
