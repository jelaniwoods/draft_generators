# frozen_string_literal: true

require "generators/draft/spike/spike_controller_generator"
require "rails/generators/rails/spike/spike_generator"

module Draft
  class SpikeGenerator < ::Rails::Generators::ScaffoldGenerator
    remove_hook_for :scaffold_controller
    remove_hook_for :assets

    def generate_controller
      invoke Draft::SpikeControllerGenerator
    end
  end
end
