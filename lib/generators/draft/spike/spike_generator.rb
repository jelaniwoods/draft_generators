# frozen_string_literal: true

require "generators/draft/spike/spike_controller_generator"
require "rails/generators/rails/spike/spike_generator"

module Draft
  class SpikeGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    remove_hook_for :template_engine

    def generate_controller
      invoke Draft::SpikeControllerGenerator
    end

    def generate_views
      invoke Draft::SpikeErbGenerator
    end
  end
end
