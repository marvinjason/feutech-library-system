var ready = function() {
  $('.ui.dropdown').dropdown();
};

$(document).on('turbolinks:load', ready);
