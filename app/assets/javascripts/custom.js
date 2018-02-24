(function() {
  $(document).on('turbolinks:load', function() {
    $('.clickable').click(function() {
      window.location = $(this).data('href');
    });
  });
})()
