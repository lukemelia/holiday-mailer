$(function(){
  setTimeout(fadeOutFlash, 1000);
});

function fadeOutFlash() {
  $('div.flash').fadeOut(2000);
}

function addFlashMessage(text) {
  $('#content').prepend("<div class='flash'>" + text + "</div>");
}
