// This is a manifest file that'll be compiled into application.js, which will
// include all the files listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts,
// vendor/assets/javascripts, or any plugin's vendor/assets/javascripts
// directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear
// at the bottom of the compiled file.
//
// Read Sprockets README for details about supported directives.
//
// https://github.com/rails/sprockets#sprockets-directives
//
//= require jquery
//= require jquery_ujs
//= require pagy
//= require_tree .

require('jquery')

$(window).load(function(){
  Pagy.init()
});

$(function(){
  $('#ask-button').click(function(){
    $('#ask-form').slideToggle(300);
    return false;
  });
});

