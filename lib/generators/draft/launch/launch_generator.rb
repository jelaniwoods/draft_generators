module Draft
  class LaunchGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def generate_layout
      log :insert, "Launch routes"

      sentinel = /\.routes\.draw do(?:\s*\|map\|)?\s*$/

      content = "\n\troot \"application#landing\"\n" +
              "  resource :launch, only: :create\n" +
              "  get \"/config\" => \"launches#xml_config\"\n" +
              "  constraints(->(request) { request.host != \"#{Rails.application.class.module_parent.to_s.underscore}.firstdraft.com\" }) do\n" +
              "    get \"/teacher\" => \"resources#teacher_backdoor\"\n" +
              "    get \"/student\" => \"resources#student_backdoor\"\n" +
              "  end"

      inside "config" do
        insert_into_file "routes.rb", content, after: sentinel
      end

      # log :insert, "Adding launches views"
      # empty_directory File.join("app/views", "launches")

      log :insert, "Adding landing page RCAV"
      log :insert, "Adding current_enrollment helper method"

      layout_sentinel = /^class ApplicationController < ActionController::Base$/
      landing_action = "  helper_method :current_enrollment\n" +
      "  def set_current_enrollment(enrollment)\n" +
      "    session[:enrollment_id] = enrollment.id\n" +
      "    @enrollment = enrollment\n" +
      "  end\n\n" +
      "  def current_enrollment\n" +
      "    @enrollment ||= Enrollment.find(session[:enrollment_id])\n" +
      "  end\n"
      landing_action += "\n  def landing; end\n"
      inside "app/controllers" do
        insert_into_file "application_controller.rb", landing_action, after: layout_sentinel
      end

      log :insert, "Adding launches controller"
      template "controllers/controller.rb", "app/controllers/launches_controller.rb"
      
      log :insert, "Adding launch model"
      run "rails g draft:model launch payload:jsonb context_id:integer resource_id:integer enrollment_id:integer user_id:integer tool_consumer_id:integer"

      log :insert, "Adding landing page"
      empty_directory File.join("app/views", "application")
      template "views/landing.html.erb", "app/views/application/landing.html.erb"
      
      log :insert, "Adding Launch Service"
      empty_directory File.join("app", "services")
      template "services/launch_service.rb", "app/services/launch_service.rb"

    end

  # private

  end
end
