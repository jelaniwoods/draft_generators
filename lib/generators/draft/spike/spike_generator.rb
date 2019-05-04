# frozen_string_literal: true

require "generators/draft/spike/spike_controller_generator"
require "rails/generators/rails/spike/spike_generator"

module Draft
  source_root File.expand_path('../templates', __FILE__)

  class SpikeGenerator < Rails::Generators::Base

    def generate_controller
      invoke Draft::SpikeControllerGenerator
    end
  end
end
