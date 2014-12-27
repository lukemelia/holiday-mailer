$(function(){
  $('.login-button').click(function(){
    HMFacebook.login();
    return false;
  });
  $('.logout-button').click(function(){
    HMFacebook.logout();
    return false;
  });
});
