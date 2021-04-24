# frozen_string_literal: true

module RedmineMentions
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_edit_notes_bottom,
              partial: 'hooks/redmine_mentions/edit_mentionable'
    render_on :view_issues_form_details_bottom,
              partial: 'hooks/redmine_mentions/edit_mentionable'
  end
end
