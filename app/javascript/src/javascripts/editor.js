$( document ).ready(function() {
    tinymce_init();
});


function tinymce_init(){
    tinymce.init({
        selector: "textarea.tinymce",

        skin: false,

        plugins: [
            "paste link"
        ],
        toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image myblock",
        relative_urls: false,
        protect2: [
            /\<\/?(if|endif)\>/g, // Protect <if> & </endif>
            /\<xsl\:[^>]+\>/g, // Protect <xsl:...>
            /<\?php.*?\?>/g // Protect php code
        ],
        setup: function(editor) {

        }
    });
}
