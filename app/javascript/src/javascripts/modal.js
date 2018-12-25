$(document).on('turbolinks:load', function() {
    var views;
    views = document.getElementById('views').value;
    if (parseInt(views) === 10) {
        $('#dialog').modal();
    }
});
