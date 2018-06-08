var ready = function() {
  $('#reserve').on('click', function() {
    $('.tiny.modal').modal('show');
  });

  $('#review-link').on('click', function(e) {
    e.preventDefault();
    $(this).hide();
    $('#review-field').show();
  });
};

// $(document).ready(ready);
$(document).on('turbolinks:load', ready);
