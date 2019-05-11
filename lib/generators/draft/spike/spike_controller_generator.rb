# frozen_string_literal: true

require "generators/draft/spike/spike_erb_generator"
require "rails/generators/rails/spike_controller/spike_controller_generator"

module Draft
  class SpikeControllerGenerator < Rails::Generators::NamedBase

    source_root File.expand_path('../templates', __FILE__)
    argument :attributes, type: :array, default: [], banner: "field:type field:type"

    def generate_views
      invoke Draft::SpikeErbGenerator
    end
  end
end
