//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require turbolinks
//= require bootstrap-tokenfield.min
//= require twitter/typeahead.min
//= require_tree .

Turbolinks.enableTransitionCache();
Turbolinks.enableProgressBar();

$.UsersAutocomplete = {
  init: function() {
    $.UsersAutocomplete.$input = $('#tokenfield');
    $.UsersAutocomplete.bloodHound();
    $.UsersAutocomplete.$input.tokenfield({
      typeahead: [null, { source: $.UsersAutocomplete.$bloodhound.ttAdapter() }]
    });
    $.UsersAutocomplete.initCallback();
  },

  bloodHound: function() {
    $.UsersAutocomplete.$bloodhound = new Bloodhound({
      remote: {
        url: '/users?query=%QUERY',
        filter: function(users) {
          return $.map(users, function(user) {
            return { value: user.email, id: user.id }
          })
        }
      },
      datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.value); },
      queryTokenizer: Bloodhound.tokenizers.whitespace
    });

    $.UsersAutocomplete.$bloodhound.initialize()
  },

  initCallback: function() {
    var users_ids = []
    var selectedHandler = function(object) {
      users_ids.push(object.attrs.id)
      $('#users_ids').val(users_ids)
    };
    $.UsersAutocomplete.$input.on('tokenfield:createtoken', selectedHandler);

    $('.typeahead.input-sm').siblings('input.tt-hint').addClass('hint-small');
    $('.typeahead.input-lg').siblings('input.tt-hint').addClass('hint-large');
  }
}

$(document).ready(function() { $.UsersAutocomplete.init() });
$(document).on('page:load', $.UsersAutocomplete.init);

$(document).ready(function(){
  $('.datepicker').datepicker()
});
$(document).on('page:load', $.UsersAutocomplete.init());
