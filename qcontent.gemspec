# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{qcontent}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Quint"]
  s.date = %q{2009-03-21}
  s.description = %q{Modules and Mixins for extending ActiveRecord models for content management systems}
  s.email = ["aaron@quirkey.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "LICENSE", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "init.rb", "lib/qcontent.rb", "lib/qcontent/assets.rb", "lib/qcontent/dimension.rb", "lib/qcontent/extensions.rb", "lib/qcontent/pricing.rb", "lib/qcontent/published.rb", "qcontent.gemspec", "rails/init.rb", "test/test_dimension.rb", "test/test_helper.rb", "test/test_qcontent.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/quirkey/qcontent}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{quirkey}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Modules and Mixins for extending ActiveRecord models for content management systems}
  s.test_files = ["test/test_dimension.rb", "test/test_helper.rb", "test/test_qcontent.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.2.0"])
      s.add_runtime_dependency(%q<money>, [">= 2.0.0"])
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.2.0"])
      s.add_dependency(%q<money>, [">= 2.0.0"])
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.2.0"])
    s.add_dependency(%q<money>, [">= 2.0.0"])
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
