# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rsolr"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Mitchell", "Jeremy Hinegardner", "Mat Brown", "Mike Perham", "Nathan Witmer", "Peter Kieltyka", "Randy Souza", "shairon toledo", "shima", "Chris Beer", "Jonathan Rochkind"]
  s.date = "2011-06-06"
  s.description = "RSolr aims to provide a simple and extensible library for working with Solr"
  s.email = "goodieboy@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/mwmitchell/rsolr"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A Ruby client for Apache Solr"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
    else
      s.add_dependency(%q<builder>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<builder>, [">= 2.1.2"])
  end
end
