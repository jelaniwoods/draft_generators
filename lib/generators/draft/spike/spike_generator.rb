# frozen_string_literal: true


module Draft
  class SpikeGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    remove_hook_for :template_engine

    def generate_controller
      return if skip_controller?

      if read_only?
        template "controllers/read_only_controller.rb", "app/controllers/#{plural_table_name.underscore}_controller.rb"
      else
        template "controllers/controller.rb", "app/controllers/#{plural_table_name.underscore}_controller.rb"
      end
    end

    def generate_model
      return if skip_model?
      invoke "draft:model"
    end

    def create_root_folder
      empty_directory File.join("app/views", "#{singular_table_name}_templates")
    end

    def generate_view_files
      available_views.each do |view|
        filename = view_filename_with_extensions(view)
        template filename, File.join("app/views", "#{singular_table_name}_templates", File.basename(options[:new_form_name].presence || filename))
      end
    end

    def generate_routes
      return if skip_controller?

      if read_only?
        read_only_routes
      else
        golden_seven_routes
      end
    end

    private

      def golden_seven_routes
        log :route, "RESTful routes"

        route <<-RUBY.gsub(/^      /, "")

          # Routes for the #{singular_table_name.humanize} resource:
          resources :#{plural_table_name}

          #------------------------------
        RUBY
      end

      def read_only_routes
        log :route, "Index and show routes"

        route <<-RUBY.gsub(/^      /, "")

          # Routes for the #{singular_table_name.humanize} resource:

          # READ
          get("/#{plural_table_name}", { :controller => "#{plural_table_name}", :action => "index" })
          get("/#{plural_table_name}/:id_to_display", { :controller => "#{plural_table_name}", :action => "show" })

          #------------------------------
        RUBY
      end

  end
end
