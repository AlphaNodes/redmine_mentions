Redmine::Plugin.register :redmine_mentions do
  name 'Redmine Mentions'
  author 'Arkhitech, Taine Woo'
  description 'This is a plugin for Redmine which gives suggestions on using username in comments'
  version '0.1.2'
  url 'https://github.com/tainewoo/redmine_mentions'
  author_url 'https://github.com/tainewoo'
  settings default: { 'trigger' => '@' }, partial: 'settings/mention'

  requires_redmine version_or_higher: '4'
end

Rails.configuration.to_prepare do
  require_dependency 'redmine_mentions/hooks'
  require_dependency 'journal'
  require_dependency 'redmine_mentions/journal_patch'
end
