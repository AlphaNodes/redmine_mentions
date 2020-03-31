
function inlineMentionAutoComplete(element) {
    'use strict';

    // do not attach if Tribute is already initialized
    // @note: problem is, we have to add a trigger for same element
    // as already exists for issues (redmine itself)
    if (element.dataset.usersActive === 'true') { return; }

    const usersUrl = element.dataset.usersUrl;
    const remoteSearch = function(url, cb) {
      const xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function ()
      {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            cb(data);
          } else if (xhr.status === 403) {
            cb([]);
          }
        }
      };
      xhr.open('GET', url, true);
      xhr.send();
    };

    const tribute = new Tribute({
      trigger: '@',
      values: function (text, cb) {
        if (event.target.type === 'text' && $(element).attr('autocomplete') != 'off') {
          $(element).attr('autocomplete', 'off');
        }
        remoteSearch(usersUrl + text, function (users) {
          return cb(users);
        });
      },
      lookup: 'label',
      fillAttr: 'label',
      requireLeadingSpace: true,
      selectTemplate: function (user) {
        return '@' + user.original.login;
      }
    });

    element.setAttribute('data-users-active', true);
    tribute.attach(element);
}
