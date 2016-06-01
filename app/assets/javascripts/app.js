var app = window.app = {};



app.Users = function() {
  this._input = $('#users-search-txt');
  this._initAutocomplete();
};

app.Users.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/users', 
        appendTo: '#users-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [
      '<span class="s-name">' + item.name + '</span><br>',
      '<span class="s-email">' + item.email + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    //this._input.val(ui.item.name + ' - ' + ui.item.email);
    this._input.val(ui.item.email);
    return false;
  }
};
