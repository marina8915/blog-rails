$(document).on('turbolinks:load', function() {
    $('.likes').hover((function() {
        $('.info', this).show();
        $('.result', this).hide();
    }), function() {
        $('.info', this).hide();
        $('.result', this).show();
    });
});
