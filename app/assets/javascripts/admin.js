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
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require admin/vendor.bundle.base
//= require admin/off-canvas
//= require admin/hoverable-collapse
//= require admin/misc
//= require dropzone

//custom functions

  Dropzone.options.filesField = {
  url: "/posts",
  method: "POST",
  addRemoveLinks: true,
  autoProcessQueue: false,
  uploadMultiple: true,
  accept: function(file, done) {
    $("div#files-field").css({"height": "auto"});
    done();
  },
  init: function() {
    var myDropzone = this;

    var form = document.getElementById('dropzone-form-id');
    form.addEventListener('submit', function(event) {
      // stop the form's submit event
      if(myDropzone.getQueuedFiles().length > 0){
        event.preventDefault();
        event.stopPropagation();
        myDropzone.processQueue();
      }
    });

    myDropzone.on("sendingmultiple", function(file, xhr, formData) {
      formData.append("title", $('#post_title').val());
      formData.append("text", $('#post_small_description').val());
    });
  },
  successmultiple: function(data,response) {
    window.location.reload()
  }
};

$(document).ready(function(){  
  $("#reset_btn").click(function(){
    var myDropzone = Dropzone.forElement(".dropzone");
    myDropzone.removeAllFiles(true);
  })
})
