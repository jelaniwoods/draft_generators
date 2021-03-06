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

  protected

    def scaffold_routes
      log :route, "Scaffolding routes"
      content = "  root \"application#landing\"" +
              "  resource :launch, only: :create" +
              "  get \"/config" => \"launches#xml_config\"" +
              "  constraints(->(request) { request.host != \"APP_NAME.firstdraft.com\" }) do" +
                "  get \"/teacher\" => \"resources#teacher_backdoor\"" +
                "  get \"/student\" => \"resources#student_backdoor\"" +
              "  end"
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
    
    def route(routing_code)
      sentinel = /\.routes\.draw do(?:\s*\|map\|)?\s*$/

      inside "config" do
        insert_into_file "routes.rb", routing_code, after: sentinel
      end
    end

    def generate_view_files
      available_views.each do |view|
        filename = view_filename_with_extensions(view)
        template filename, File.join("app/views", "launches", File.basename( filename))
      end
    end

  end
end
