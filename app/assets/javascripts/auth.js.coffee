$(->
  $('.login-button').click ->
    HMFacebook.login()
    false
  $('.logout-button').click ->
    HMFacebook.logout()
    false
)
