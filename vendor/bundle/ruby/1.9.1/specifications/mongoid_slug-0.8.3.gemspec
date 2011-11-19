# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongoid_slug"
  s.version = "0.8.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paper Cavalier"]
  s.date = "2011-08-20"
  s.description = "Mongoid Slug generates a URL slug or permalink based on one or more fields in a Mongoid model."
  s.email = ["code@papercavalier.com"]
  s.homepage = "http://github.com/papercavalier/mongoid-slug"
  s.require_paths = ["lib"]
  s.rubyforge_project = "mongoid_slug"
  s.rubygems_version = "1.8.10"
  s.summary = "Generates a URL slug"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, ["~> 2.0"])
      s.add_runtime_dependency(%q<stringex>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, ["~> 0.9"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6"])
    else
      s.add_dependency(%q<mongoid>, ["~> 2.0"])
      s.add_dependency(%q<stringex>, ["~> 1.3"])
      s.add_dependency(%q<rake>, ["~> 0.9"])
      s.add_dependency(%q<rspec>, ["~> 2.6"])
    end
  else
    s.add_dependency(%q<mongoid>, ["~> 2.0"])
    s.add_dependency(%q<stringex>, ["~> 1.3"])
    s.add_dependency(%q<rake>, ["~> 0.9"])
    s.add_dependency(%q<rspec>, ["~> 2.6"])
  end
end
