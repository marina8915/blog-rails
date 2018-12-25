$(document).on('turbolinks:load', function() {
    var d, spans;
    spans = document.getElementsByClassName('ch');
    if (spans.length === 0) {
        $('.flp label').each(function() {
            var scl, sop;
            sop = '<span class="ch">';
            scl = '</span>';
            $(this).html(sop + $(this).html().split('').join(scl + sop) + scl);
            $('.ch:contains(\' \')').html('&nbsp;');
        });
        d = void 0;
    }
    $('.flp input').focus(function() {
        var tm;
        var tm;
        tm = $(this).outerHeight() / 2 * -1 + 'px';
        $(this).next().addClass('focussed').children().stop(true).each(function(i) {
            d = i * 50;
            $(this).delay(d).animate({
                top: tm
            }, 200, 'easeOutBack');
        });
    });
    $('.flp input').blur(function() {
        if ($(this).val() === '') {
            $(this).next().removeClass('focussed').children().stop(true).each(function(i) {
                d = i * 50;
                $(this).delay(d).animate({
                    top: 0
                }, 500, 'easeInOutBack');
            });
        }
    });
});
