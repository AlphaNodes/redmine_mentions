require_dependency 'journal'

class Journal
  after_create :send_mail

  private

  def send_mail
    return unless journalized.is_a?(Issue) && notes.present?

    users = journalized.project.users.to_a.delete_if { |u| (u.type != 'User' || u.mail.empty?) }
    users_regex = users.collect { |u| "#{Setting.plugin_redmine_mentions['trigger']}#{u.login}" }.join('|')
    regex_for_email = '\B(' + users_regex + ')\b'
    regex = Regexp.new(regex_for_email)
    mentioned_users = notes.scan(regex)
    mentioned_users.each do |mentioned_user|
      username = mentioned_user.first[1..-1]
      user = User.find_by(login: username)
      next unless user

      MentionMailer.notify_mentioning(journalized, self, user).deliver
    end
  end
end
