# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: draft_generators 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "draft_generators".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Raghu Betina".freeze]
  s.date = "2019-05-18"
  s.description = "This is a set of generators that help beginners learn to program. Primarily, they generate code that is more explicit and verbose and less idiomatic and \u201Cmagical\u201D than the built-in scaffold generator, which is helpful for beginners while they are learning how exactly things are wired together.".freeze
  s.email = "raghu@firstdraft.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".codeclimate.yml",
    ".document",
    ".rspec",
    ".rubocop.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "draft_generators.gemspec",
    "lib/devise_customization_service.rb",
    "lib/draft_generators.rb",
    "lib/generators/draft/devise/devise_generator.rb",
    "lib/generators/draft/devise/views/templates/confirmations/new.html.erb",
    "lib/generators/draft/devise/views/templates/mailer/confirmation_instructions.html.erb",
    "lib/generators/draft/devise/views/templates/mailer/email_changed.html.erb",
    "lib/generators/draft/devise/views/templates/mailer/password_change.html.erb",
    "lib/generators/draft/devise/views/templates/mailer/reset_password_instructions.html.erb",
    "lib/generators/draft/devise/views/templates/mailer/unlock_instructions.html.erb",
    "lib/generators/draft/devise/views/templates/passwords/edit.html.erb",
    "lib/generators/draft/devise/views/templates/passwords/new.html.erb",
    "lib/generators/draft/devise/views/templates/registrations/edit.html.erb",
    "lib/generators/draft/devise/views/templates/registrations/new.html.erb",
    "lib/generators/draft/devise/views/templates/registrations_with_sentinels/edit.html.erb",
    "lib/generators/draft/devise/views/templates/registrations_with_sentinels/new.html.erb",
    "lib/generators/draft/devise/views/templates/sessions/new.html.erb",
    "lib/generators/draft/devise/views/templates/shared/_links.html.erb",
    "lib/generators/draft/devise/views/templates/unlocks/new.html.erb",
    "lib/generators/draft/devise/views/views_generator.rb",
    "lib/generators/draft/launch/USAGE",
    "lib/generators/draft/launch/launch_generator.rb",
    "lib/generators/draft/launch/templates/controllers/controller.rb",
    "lib/generators/draft/launch/templates/views/landing.html.erb",
    "lib/generators/draft/layout/USAGE",
    "lib/generators/draft/layout/layout_generator.rb",
    "lib/generators/draft/layout/templates/_bootstrapcdn_assets.html.erb",
    "lib/generators/draft/layout/templates/_flashes.html.erb",
    "lib/generators/draft/layout/templates/_navbar.html.erb",
    "lib/generators/draft/layout/templates/layout.html.erb",
    "lib/generators/draft/lti/USAGE",
    "lib/generators/draft/lti/lti_generator.rb",
    "lib/generators/draft/lti/templates/controllers/controller.rb",
    "lib/generators/draft/lti/templates/views/_card.html.erb",
    "lib/generators/draft/lti/templates/views/_form.html.erb",
    "lib/generators/draft/lti/templates/views/edit.html.erb",
    "lib/generators/draft/lti/templates/views/index.html.erb",
    "lib/generators/draft/lti/templates/views/new.html.erb",
    "lib/generators/draft/lti/templates/views/show.html.erb",
    "lib/generators/draft/lti_cancelled/lti_cancelled_generator.rb",
    "lib/generators/draft/lti_cancelled/templates/controllers/controller.rb",
    "lib/generators/draft/lti_cancelled/templates/views/_card.html.erb",
    "lib/generators/draft/lti_cancelled/templates/views/_form.html.erb",
    "lib/generators/draft/lti_cancelled/templates/views/edit.html.erb",
    "lib/generators/draft/lti_cancelled/templates/views/index.html.erb",
    "lib/generators/draft/lti_cancelled/templates/views/new.html.erb",
    "lib/generators/draft/lti_cancelled/templates/views/show.html.erb",
    "lib/generators/draft/lti_layout/USAGE",
    "lib/generators/draft/lti_layout/lti_layout_generator.rb",
    "lib/generators/draft/lti_layout/templates/landing.html.erb",
    "lib/generators/draft/model/USAGE",
    "lib/generators/draft/model/model_generator.rb",
    "lib/generators/draft/resource/USAGE",
    "lib/generators/draft/resource/resource_generator.rb",
    "lib/generators/draft/resource/templates/controllers/controller.rb",
    "lib/generators/draft/resource/templates/controllers/read_only_controller.rb",
    "lib/generators/draft/resource/templates/specs/crud_spec.rb",
    "lib/generators/draft/resource/templates/specs/factories.rb",
    "lib/generators/draft/resource/templates/views/association_new_form.html.erb",
    "lib/generators/draft/resource/templates/views/create_row.html.erb",
    "lib/generators/draft/resource/templates/views/destroy_row.html.erb",
    "lib/generators/draft/resource/templates/views/edit_form.html.erb",
    "lib/generators/draft/resource/templates/views/edit_form_with_errors.html.erb",
    "lib/generators/draft/resource/templates/views/index.html.erb",
    "lib/generators/draft/resource/templates/views/new_form.html.erb",
    "lib/generators/draft/resource/templates/views/new_form_with_errors.html.erb",
    "lib/generators/draft/resource/templates/views/show.html.erb",
    "lib/generators/draft/resource/templates/views/update_row.html.erb",
    "lib/generators/draft/scaffold/scaffold_controller_generator.rb",
    "lib/generators/draft/scaffold/scaffold_erb_generator.rb",
    "lib/generators/draft/scaffold/scaffold_generator.rb",
    "lib/generators/draft/scaffold/templates/_card.html.erb",
    "lib/generators/draft/scaffold/templates/_form.html.erb",
    "lib/generators/draft/scaffold/templates/_list_item.html.erb",
    "lib/generators/draft/scaffold/templates/_table_row.html.erb",
    "lib/generators/draft/scaffold/templates/edit.html.erb",
    "lib/generators/draft/scaffold/templates/index.html.erb",
    "lib/generators/draft/scaffold/templates/new.html.erb",
    "lib/generators/draft/scaffold/templates/show.html.erb",
    "lib/generators/draft/spike/spike_generator.rb",
    "lib/generators/draft/spike/templates/controllers/controller.rb",
    "lib/generators/draft/spike/templates/controllers/read_only_controller.rb",
    "lib/generators/draft/spike/templates/views/_card.html.erb",
    "lib/generators/draft/spike/templates/views/_form.html.erb",
    "lib/generators/draft/spike/templates/views/edit.html.erb",
    "lib/generators/draft/spike/templates/views/index.html.erb",
    "lib/generators/draft/spike/templates/views/new.html.erb",
    "lib/generators/draft/spike/templates/views/show.html.erb",
    "lib/rails_tag_service.rb"
  ]
  s.homepage = "http://github.com/raghubetina/draft_generators".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Generators that help beginners learn to program.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<devise>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    else
      s.add_dependency(%q<devise>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<devise>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

