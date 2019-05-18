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
        template filename, File.join("app/views", plural_table_name, File.basename(options[:new_form_name].presence || filename))
      end
    end

    def generate_routes
      scaffold_routes
    end

  private

    def scaffold_routes
      log :route, "Scaffolding routes"
      route <<-RUBY.gsub(/^      /, "")

      # Routes for the #{singular_table_name.humanize} resource:

      # CREATE
      get("/#{plural_table_name}/new", { :controller => "#{plural_table_name}", :action => "new_form" })
      #{skip_post? ? "get" : "post"}("/create_#{singular_table_name}", { :controller => "#{plural_table_name}", :action => "create_row" })

      # READ
      get("/#{plural_table_name}", { :controller => "#{plural_table_name}", :action => "index" })
      get("/#{plural_table_name}/:id_to_display", { :controller => "#{plural_table_name}", :action => "show" })

      # UPDATE
      get("/#{plural_table_name}/:prefill_with_id/edit", { :controller => "#{plural_table_name}", :action => "edit_form" })
      #{skip_post? ? "get" : "post"}("/update_#{singular_table_name}/:id_to_modify", { :controller => "#{plural_table_name}", :action => "update_row" })

      # DELETE
      get("/delete_#{singular_table_name}/:id_to_remove", { :controller => "#{plural_table_name}", :action => "destroy_row" })

      #------------------------------
    RUBY
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
