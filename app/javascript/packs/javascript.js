// jquery

import $ from 'jquery'
global.$ = $
global.jQuery = $

// bootstrap
import 'bootstrap/dist/js/bootstrap';


// images
require.context('../images/', true, /\.(gif|jpg|png|svg)$/i)