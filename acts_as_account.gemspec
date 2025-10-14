# frozen_string_literal: true
# -*- encoding: utf-8 -*-
# stub: acts_as_account 3.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "acts_as_account"
  s.version = "3.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Thies C. Arntzen, Norman Timmler, Matthias Frick, Phillip Oertel"]
  s.date = "2020-01-30"
  s.description = "acts_as_account implements double entry accounting for Rails models. Your models get accounts and you can do consistent transactions between them. Since the documentation is sparse, see the spec files for usage examples."
  s.email = "developers@betterplace.org"
  s.extra_rdoc_files = ["README.rdoc", "lib/acts_as_account.rb", "lib/acts_as_account/account.rb", "lib/acts_as_account/active_record_extensions.rb", "lib/acts_as_account/global_account.rb", "lib/acts_as_account/journal.rb", "lib/acts_as_account/manually_created_account.rb", "lib/acts_as_account/posting.rb", "lib/acts_as_account/rails.rb", "lib/acts_as_account/transfer.rb", "lib/acts_as_account/version.rb"]
  s.files = [".gitignore", ".travis.yml", "CHANGELOG.md", "Gemfile", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "acts_as_account.gemspec", "init.rb", "lib/acts_as_account.rb", "lib/acts_as_account/account.rb", "lib/acts_as_account/active_record_extensions.rb", "lib/acts_as_account/global_account.rb", "lib/acts_as_account/journal.rb", "lib/acts_as_account/manually_created_account.rb", "lib/acts_as_account/posting.rb", "lib/acts_as_account/rails.rb", "lib/acts_as_account/transfer.rb", "lib/acts_as_account/version.rb", "spec/spec_helper.rb", "spec/account_creation_spec.rb", "spec/journal_creation_spec.rb", "spec/transfer_spec.rb", "spec/db/database.yml", "spec/db/schema.rb", "spec/support/models.rb", "spec/support/helpers.rb"]
  s.homepage = "http://github.com/betterplace/acts_as_account"
  s.licenses = ["Apache-2.0"]
  s.rdoc_options = ["--title", "ActsAsAccount -- More Math in Ruby", "--main", "README.rdoc"]
  s.rubygems_version = "3.5.16"
  s.summary = "acts_as_account implements double entry accounting for Rails models"
  s.required_ruby_version = "2.6.4"

  s.add_development_dependency(%q<gem_hadar>, ["~> 1.9.1"])
  s.add_development_dependency(%q<mysql2>, [">= 0"])
  s.add_development_dependency(%q<rspec>, ["~> 3.1"])
  s.add_development_dependency(%q<simplecov>, [">= 0"])
  s.add_development_dependency(%q<complex_config>, [">= 0"])
  s.add_runtime_dependency(%q<activerecord>, [">= 4.1", "< 7"])
  s.add_runtime_dependency(%q<actionpack>, [">= 4.1", "< 7"])
  s.add_runtime_dependency(%q<database_cleaner>, ["~> 1.3"])
end
