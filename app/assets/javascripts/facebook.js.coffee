window.HMFacebook =
  init: (initializedCallback)->
    if window.FB?
      initializedCallback?()
    else
      window.fbAsyncInit = (->
        FB.init
          appId      : window.FACEBOOK_APP_ID
          channelUrl : '//' + window.location.hostname + '/channel.html'
          status     : false
          cookie     : false
          oauth      : true
          xfbml      : false

        initializedCallback?()
      )

      ((d)->
         id = 'facebook-jssdk'
         if (d.getElementById(id)) then return
         js = d.createElement('script')
         js.id = id
         js.async = true
         js.src = "//connect.facebook.net/en_US/all.js"
         d.getElementsByTagName('head')[0].appendChild(js)
      )(document)

  login: (appId, successCallback)->
    HMFacebook.init ->
      FB.login( (response)->
        if response.authResponse
          $.ajax('/sessions/facebook_oauth_token_update',
            type: 'PUT'
            dataType: 'json'
            xhrFields:
              withCredentials: true
            data:
              access_token: response.authResponse.accessToken
              expires_in: response.authResponse.expiresIn
              app_id: appId
          ).done (data)->
            if successCallback?
              successCallback()
            else
              window.location = data.location
        else
          console.log('User cancelled login or did not fully authorize.')
      , { scope: 'email' })
      
  logout: (successCallback)->
    $.ajax('/sessions/logout',
      type: 'DELETE'
      dataType: 'json'
      xhrFields:
        withCredentials: true
    ).done (data)->
      if successCallback?
        successCallback()
      else
        window.location.reload()
