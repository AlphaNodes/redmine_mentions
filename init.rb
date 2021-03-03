Redmine::Plugin.register :redmine_mentions do
  name 'Redmine Mentions'
  author 'Arkhitech, Taine Woo'
  description 'This is a plugin for Redmine which gives suggestions on using username in comments'
  version '1.0.0'
  url 'https://github.com/AlphaNodes/redmine_mentions'
  author_url 'https://github.com/tainewoo'

  requires_redmine version_or_higher: '4.1'
end

Rails.configuration.to_prepare do
  require_dependency 'redmine_mentions/hooks'
  require_dependency 'journal'
  require_dependency 'redmine_mentions/journal_patch'
  require_dependency 'redmine_mentions/auto_completes_controller_patch'
end
