var ready = function() {
  $('#reserve').on('click', function() {
    $('.tiny.modal').modal('show');
  });
};

// $(document).ready(ready);
$(document).on('turbolinks:load', ready);
