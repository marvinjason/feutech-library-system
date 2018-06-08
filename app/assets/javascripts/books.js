var ready = function() {
  $('#reserve').on('click', function() {
    $('.tiny.modal').modal('show');
  });

  $('#review-link').on('click', function(e) {
    e.preventDefault();
    $(this).hide();
    $('#review-field').show();
  });

  $('.ui.rating').rating('setting', 'onRate', function(value) {
    $('#rating').val(value);
  });
};

// $(document).ready(ready);
$(document).on('turbolinks:load', ready);
