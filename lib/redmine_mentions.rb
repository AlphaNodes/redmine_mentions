# frozen_string_literal: true

require 'redmine_mentions/version'

module RedmineMentions
  class << self
    def setup
      Journal.include RedmineMentions::Patches::JournalPatch
      Mailer.include RedmineMentions::Patches::MailerPatch
      AutoCompletesController.include RedmineMentions::Patches::AutoCompletesControllerPatch

      # hooks
      require_dependency 'redmine_mentions/hooks'
    end
  end
end
