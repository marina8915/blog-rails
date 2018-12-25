// core
import tinymce from 'tinymce/tinymce'
import 'tinymce/themes/modern/theme'


// plugins
import 'tinymce/plugins/paste/plugin'
import 'tinymce/plugins/link/plugin'
import 'tinymce/plugins/autoresize/plugin'


// skins
require.context('file-loader?name=[path][name].[ext]&context=node_modules/tinymce!tinymce/skins', true,    /.*/ );
