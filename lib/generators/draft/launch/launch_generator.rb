module Draft
  class LaunchGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def generate_layout
      log :insert, "Scaffolding routes"

      sentinel = /\.routes\.draw do(?:\s*\|map\|)?\s*$/

      content = "  root \"application#landing\"" +
              "  resource :launch, only: :create" +
              "  get \"/config" => \"launches#xml_config\"" +
              "  get \"/landing\", to: \"application#landing\", as: \"landing\""

      inside "config" do
        insert_into_file "routes.rb", content, after: sentinel
      end

      log :insert, "Adding launches views"
      empty_directory File.join("app/views", "launches")

      log :insert, "Adding launches controller"
      template "controllers/controller.rb", "app/controllers/launches_controller.rb"
      
      log :insert, "Adding launch model"
      invoke "draft:model payload:jsonb context_id:integer resource_id:integer enrollment_id:integer user_id:integer tool_consumer_id:integer"

      log :insert, "Adding landing page"
      template "views/landing.html.erb", "app/views/launches/landing.html.erb"

    end

  # private

  end
end
