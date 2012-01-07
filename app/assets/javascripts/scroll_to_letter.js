$(function(){
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