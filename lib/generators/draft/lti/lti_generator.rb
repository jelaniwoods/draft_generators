module Draft
  class LtiGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)

    argument :attributes, type: :array, default: [], banner: "field:type field:type"

    def generate_controller
      template "controllers/controller.rb", "app/controllers/#{plural_table_name.underscore}_controller.rb"
    end

    def generate_model
      invoke "draft:model"
    end
    
    def create_root_folder
      empty_directory File.join("app/views", plural_table_name)
    end

    def generate_view_files
      available_views.each do |view|
        filename = view_filename_with_extensions(view)
        template filename, File.join("app/views", plural_table_name.concat(".html.erb")))
      end
    end

    def generate_routes
      scaffold_routes
    end

    private 
  
      def launch_and_config_routes
        log :route, "Launch and Config routes"

        route <<-RUBY.gsub(/^      /, "")

          root "application#landing"
          get "/landing", to: "application#landing", as: "landing"
          get "/config" => "launches#xml_config"
        RUBY 
      end
      
      def scaffold_routes
        log :route, "Scaffolding routes"
        if singular_table_name == "launch"
          route <<-RUBY.gsub(/^      /, "")

            resources plural_table_name.to_sym, only: :create
          RUBY
        end
        if singular_table_name == "administrator"
          route <<-RUBY.gsub(/^      /, "")

            devise_for plural_table_name.to_sym
          RUBY 

        else
          route <<-RUBY.gsub(/^      /, "")

            resources plural_table_name.to_sym, only: %i[]
          RUBY         
        end
      end
      
      def route(routing_code)
        sentinel = /\.routes\.draw do(?:\s*\|map\|)?\s*$/

        inside "config" do
          insert_into_file "routes.rb", routing_code, after: sentinel
        end
      end

      def available_views
        %w(index new edit show _card)
      end
  
      def view_filename_with_extensions(name)
        filename = [name, :html, :erb].compact.join(".")
        folders = ["views"]
        filename = File.join(folders, filename) if folders.any?
        filename
      end
    end
  end
end
