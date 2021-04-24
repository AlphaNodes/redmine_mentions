# frozen_string_literal: true

class MentionMailer < ActionMailer::Base
  layout 'mailer'
  default from: Setting.mail_from

  helper :application
  include ApplicationHelper

  def self.default_url_options
    ::Mailer.default_url_options
  end

  def notify_mentioning(issue, journal, user)
    @issue = issue
    @journal = journal
    mail to: user.mail,
         subject: "[#{@issue.project.name} - #{@issue.tracker.name} ##{@issue.id}] #{l :subject_you_were_mentioned} #{@issue.subject}"
  end
end
