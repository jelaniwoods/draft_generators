module Draft
  class LaunchGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    
    def generate_layout
      
      log :insert, "Adding Bootstrap"
      template "views/landing.html.erb", "app/views/launches/landing.html.erb"

    end

  protected

  end
end
