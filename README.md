Redmine Mentions
================

Allows users to mention team members in their notes/comments.

![Run RuboCop](https://github.com/AlphaNodes/redmine_mentions/workflows/Run%20RuboCop/badge.svg) ![Run Tests](https://github.com/AlphaNodes/redmine_mentions/workflows/Run%20Tests/badge.svg)

Redmine site: https://www.redmine.org/plugins/redmine-mentions


Functionality
==============
In editing an issue, user can mention his/her colleagues username that are part of the project from the drop down list,
the mentioned user receives an email with the body of the comment and information who mentioned him on particular issue.

'@' sign is used as the trigger for the mentioning.


Requirements
============

- Redmine 4.1 (because same mechanism as for issues is used, which comes with Redmine 4.1)

Installation
============
To Install this plugin goto plugins in your redmine repository

Clone the git repository:

  cd plugins
	git clone git://github.com/tainewoo/redmine_mentions.git

Restart Redmine
