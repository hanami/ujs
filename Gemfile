# frozen_string_literal: true

source "https://rubygems.org"
gemspec

unless ENV["TRAVIS"]
  gem "byebug", require: false, platforms: :mri if RUBY_VERSION >= "2.2.0"
  gem "yard",   require: false
end

gem "vanilla-ujs", "1.3.0"

gem "hanami-utils",       "~> 1.3", require: false, git: "https://github.com/hanami/utils.git",       branch: "master"
gem "hanami-validations", "~> 1.3", require: false, git: "https://github.com/hanami/validations.git", branch: "master"
gem "hanami-router",      "~> 1.3", require: false, git: "https://github.com/hanami/router.git",      branch: "master"
gem "hanami-controller",  "~> 1.3", require: false, git: "https://github.com/hanami/controller.git",  branch: "master"
gem "hanami-view",        "~> 1.3", require: false, git: "https://github.com/hanami/view.git",        branch: "master"
gem "hanami-model",       "~> 1.3", require: false, git: "https://github.com/hanami/model.git",       branch: "master"
gem "hanami-helpers",     "~> 1.3", require: false, git: "https://github.com/hanami/helpers.git",     branch: "master"
gem "hanami-mailer",      "~> 1.3", require: false, git: "https://github.com/hanami/mailer.git",      branch: "master"
gem "hanami-assets",      "~> 1.3", require: false, git: "https://github.com/hanami/assets.git",      branch: "master"
gem "hanami-cli",         "~> 0.3", require: false, git: "https://github.com/hanami/cli.git",         branch: "master"
gem "hanami",             "~> 1.3", require: false, git: "https://github.com/hanami/hanami.git",      branch: "master"
gem "hanami-webconsole",  "~> 0.2", require: false, git: "https://github.com/hanami/webconsole.git",  branch: "master"

gem "hanami-devtools", git: "https://github.com/hanami/devtools.git", require: false

platforms :ruby do
  gem "sqlite3"
end

platforms :jruby do
  gem "jdbc-sqlite3"
end
