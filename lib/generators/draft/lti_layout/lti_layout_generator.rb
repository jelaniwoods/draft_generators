module Draft
  class LtiLayoutGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_layout
      log :insert, "Generating Launch Route, Migration, Model, Controller, View "
      scaffold_routes
      create_root_folder
      generate_controller
      generate_model

    end

  private

    def scaffold_routes
      log :route, "Scaffolding routes"
      content = "  root \"application#landing\"" +
              "  resource :launch, only: :create" +
              "  get \"/config" => \"launches#xml_config\"" +
              "  get \"/landing\", to: \"application#landing\", as: \"landing\""
      route(content)
    end
  
    
    def generate_controller
      template "controllers/controller.rb", "app/controllers/launches_controller.rb"
    end

    def generate_model
      invoke "draft:model payload:jsonb context_id:integer resource_id:integer enrollment_id:integer user_id:integer tool_consumer_id:integer"
    end

    def create_root_folder
      empty_directory File.join("app/views", "launches")
    end


    def generate_view_files
      available_views.each do |view|
        filename = view_filename_with_extensions(view)
        template filename, File.join("app/views", "launches", File.basename( filename))
      end
    end

  end
end
