# frozen_string_literal: true

raise "\n\033[31maredmine_saml requires ruby 2.6 or newer. Please update your ruby version.\033[0m" if RUBY_VERSION < '2.6'

Redmine::Plugin.register :redmine_mentions do
  name 'Redmine Mentions'
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'
  url 'https://github.com/AlphaNodes/redmine_mentions'
  description 'This is a plugin for Redmine which gives suggestions on using username in comments'
  version '1.0.1'

  requires_redmine version_or_higher: '4.1'
end

Rails.configuration.to_prepare do
  require_dependency 'redmine_mentions/hooks'
  require_dependency 'journal'
  require_dependency 'redmine_mentions/journal_patch'
  require_dependency 'redmine_mentions/auto_completes_controller_patch'
end
