// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $("form :input:visible:enabled:first").focus();
  function fadeOutFlash() {
    $('div.flash').fadeOut(2000);
  }
  setTimeout(fadeOutFlash, 1000);
  
  function addFlashMessage(text) {
    $('#content').prepend("<div class='flash'>" + text + "</div>");
  }
  
  var functionForScrollToLetter = function(letter) {
    return function() {
      var $target = $('.letter_' + letter + ':first');
      if ($target.length > 0) {
        var targetOffset = $target.offset().top;
        $('html,body').animate({scrollTop: targetOffset}, 1000);
        addFlashMessage(letter);
        fadeOutFlash();
      }
    };
  };
  var alphaHotKeyHash = {};
  for (var i = 0; i < 26; i++) {
    var letter = String.fromCharCode(i + 65).toLowerCase();
    alphaHotKeyHash[letter] = functionForScrollToLetter(letter);
  }
  $.hotkeys(alphaHotKeyHash);
});