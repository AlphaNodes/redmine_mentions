# frozen_string_literal: true

module RedmineMentions
  module Patches
    module JournalPatch
      extend ActiveSupport::Concern

      included do
        include InstanceMethods

        after_create :send_mail
      end

      module InstanceMethods
        private

        def send_mail
          return unless journalized.is_a?(Issue) && notes.present?

          logins = journalized.project
                              .users
                              .where(type: 'User')
                              .pluck(:login)

          users_regex = logins.map { |u| "@#{u}" }.join '|'
          regex = Regexp.new(/\B(#{users_regex})\b/)
          mentioned_users = notes.scan regex
          mentioned_users.each do |mentioned_user|
            username = mentioned_user.first[1..]
            user = User.find_by login: username
            next unless user

            Mailer.notify_mentioning(user, journalized, self).deliver
          end
        end
      end
    end
  end
end
