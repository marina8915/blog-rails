/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from 'activestorage';
Rails.start();
Turbolinks.start();
ActiveStorage.start();

// jquery
import $ from 'jquery';
global.$ = $;
global.jQuery = $;

// bootstrap
import 'bootstrap/dist/js/bootstrap';

// images
require.context('../src/images/', true, /\.(gif|jpg|png|svg)$/i)

import Likes from '../src/javascripts/comment-likes.js';
import Stars from '../src/javascripts/post-stars.js';
import Barrating from '../src/javascripts/jquery.barrating.min.js';
import Login from '../src/javascripts/login.js';
import Modal from '../src/javascripts/modal.js';
import Editor from '../src/javascripts/editor.js';
