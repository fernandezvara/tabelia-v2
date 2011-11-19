# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "trackoid"
  s.version = "0.3.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jose Miguel Perez"]
  s.date = "2011-09-05"
  s.description = "Trackoid uses an embeddable approach to track analytics data using the poweful features of MongoDB for scalability"
  s.email = "josemiguel@perezruiz.com"
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/twoixter/trackoid"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Trackoid is an easy scalable analytics tracker using MongoDB and Mongoid"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, [">= 2.1.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.2.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<mongoid>, [">= 2.1.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.2.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongoid>, [">= 2.1.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.2.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
