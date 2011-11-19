# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongoid_i18n"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rodrigo \u{c3}\u{81}lvarez"]
  s.date = "2011-10-17"
  s.description = "This gem aims to be a transparent way to deal with localizable fields.\n      Basically use localized_field() instead of field() and that's it.\n      It will take care of locales for you when using find or criteria.\n      "
  s.email = "papipo@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/Papipo/mongoid_i18n"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Mongoid plugin to deal with localizable fields"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, [">= 2.1.0"])
      s.add_development_dependency(%q<bson_ext>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
    else
      s.add_dependency(%q<mongoid>, [">= 2.1.0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongoid>, [">= 2.1.0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
  end
end
