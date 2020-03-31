require_dependency 'journal'

class Journal
  after_create :send_mail

  private

  def send_mail
    return unless journalized.is_a?(Issue) && notes.present?

    logins = journalized.project
                        .users
                        .where(type: 'User')
                        .pluck(:login)

    users_regex = logins.map { |u| "@#{u}" }.join('|')
    regex = Regexp.new('\B(' + users_regex + ')\b')
    mentioned_users = notes.scan(regex)
    mentioned_users.each do |mentioned_user|
      username = mentioned_user.first[1..-1]
      user = User.find_by(login: username)
      next unless user

      MentionMailer.notify_mentioning(journalized, self, user).deliver
    end
  end
end
