# frozen_string_literal: true

module RedmineMentions
  module Patches
    module MailerPatch
      extend ActiveSupport::Concern

      included do
        include InstanceMethods
      end

      module InstanceMethods
        def notify_mentioning(user, issue, journal)
          @issue = issue
          @journal = journal
          mail to: user.mail,
               subject: "[#{@issue.project.name} - #{@issue.tracker.name} ##{@issue.id}] #{l :subject_you_were_mentioned} #{@issue.subject}"
        end
      end
    end
  end
end
