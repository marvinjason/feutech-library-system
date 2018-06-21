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

  $('#form-from').on('change', function(e) {
    var from = e.target.value;
    var to = $('#form-to').val();

    if (Date.parse(from) < Date.parse(to)) {
      $('#form-button').removeAttr('disabled');
    } else {
      $('#form-button').attr('disabled', 'disabled');
    }
  });

  $('#form-to').on('change', function(e) {
    var from = $('#form-from').val();
    var to = e.target.value;

    if (Date.parse(from) < Date.parse(to)) {
      $('#form-button').removeAttr('disabled');
    } else {
      $('#form-button').attr('disabled', 'disabled');
    }
  });
};

// $(document).ready(ready);
$(document).on('turbolinks:load', ready);
