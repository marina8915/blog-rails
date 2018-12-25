$(document).on('turbolinks:load', function() {
    var stars;
    stars = document.getElementsByClassName('br-widget');
    if (stars.length === 0) {
        $('#rating').barrating({
            theme: 'fontawesome-stars'
        });
    }
});
