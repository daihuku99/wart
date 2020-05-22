// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
//= require jquery
//= require moment
//= require fullcalendar

$(function () {
    function eventCalendar() {
        return $('#calendar').fullCalendar({});
    };
    function clearCalendar() {
        $('#calendar').html('');
    };
    $(document).on('turbolinks:load', function () {
    eventCalendar();
    });
    $(document).on('turbolinks:before-cache', clearCalendar);

    $('#calendar').fullCalendar({
    events: '/events.json'
    });
});


$(function(){
  $('.modal-container').on('click', function(){
    var btnIndex = $(this).index();
    console.log(btnIndex)
    $('.js-modal').eq(btnIndex).fadeIn();
    return false;
  });
  $('.js-modal-close').on('click', function(){
    $('.js-modal').fadeOut();
    return false;
  });
});

$(function(){
    function readURL(input) {
        if (input.files && input.files[0]){
            var reader = new FileReader();
            reader.onload = function (e){
              $('.image_prev').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $('.image_field').change(function(){
        readURL(this);
    });
});

$(function(){
  var count = $(".count").length;
  if( count == 0 ){
    $('.message').html('展覧会はありません');
   }
});