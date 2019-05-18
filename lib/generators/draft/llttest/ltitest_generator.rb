module Draft
  class LtitestGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)

    argument :attributes, type: :array, default: [], banner: "field:type field:type"


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

    def generate_specs
      # Hotfix to prevent specs during MSM Associations
      return
      # return if read_only? || skip_controller? || skip_model?

      template "specs/crud_spec.rb", "spec/features/crud_#{plural_table_name.underscore}_spec.rb"
      template "specs/factories.rb", "spec/factories/#{plural_table_name.underscore}.rb"
    end

  private

    def golden_seven_routes
      log :route, "RESTful routes"

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

    def skip_controller?
      options[:skip_controller] || options[:only_new_form]
    end

    def skip_model?
      options[:skip_model] || options[:only_new_form]
    end

    def read_only?
      options[:read_only]
    end

    def skip_validation_alerts?
      options[:skip_validation_alerts]
    end

    def skip_post?
      options[:skip_post]
    end

    def skip_redirect?
      options[:skip_redirect]
    end

    def only_new_form?
      options[:only_new_form]
    end

    def with_sentinels?
      options[:with_sentinels]
    end

    def new_form_hidden_variable
      "@#{options[:associated_table_name].singularize}.id"
    end

    def new_form_create_path
      "create_#{singular_table_name}_from_#{options[:associated_table_name].singularize}"
    end

    def route(routing_code)
      sentinel = /\.routes\.draw do(?:\s*\|map\|)?\s*$/

      inside "config" do
        insert_into_file "routes.rb", routing_code, after: sentinel
      end
    end

    def available_views
      if read_only?
        %w(index show)
      elsif skip_redirect?
        %w(index show new_form create_row edit_form update_row destroy_row)
      elsif only_new_form?
        %w(association_new_form)
      else
        %w(index new_form new_form_with_errors edit_form edit_form_with_errors show)
      end
    end

    def view_filename_with_extensions(name)
      filename = [name, :html, :erb].compact.join(".")
      folders = ["views"]
      filename = File.join(folders, filename) if folders.any?
      filename
    end
  end
end
