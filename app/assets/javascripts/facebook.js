window.HMFacebook = {
  init: function(initializedCallback) {
    if (window.FB) {
      return typeof initializedCallback === "function" ? initializedCallback() : void 0;
    } else {
      window.fbAsyncInit = (function() {
        FB.init({
          appId: window.FACEBOOK_APP_ID,
          channelUrl: '//' + window.location.hostname + '/channel.html',
          status: false,
          cookie: false,
          oauth: true,
          xfbml: false
        });
        return typeof initializedCallback === "function" ? initializedCallback() : void 0;
      });
      return (function(d) {
        var id, js;
        id = 'facebook-jssdk';
        if (d.getElementById(id)) {
          return;
        }
        js = d.createElement('script');
        js.id = id;
        js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        return d.getElementsByTagName('head')[0].appendChild(js);
      })(document);
    }
  },
  login: function(appId, successCallback) {
    return HMFacebook.init(function() {
      return FB.login(function(response) {
        if (response.authResponse) {
          return $.ajax('/sessions/facebook_oauth_token_update', {
            type: 'PUT',
            dataType: 'json',
            xhrFields: {
              withCredentials: true
            },
            data: {
              access_token: response.authResponse.accessToken,
              expires_in: response.authResponse.expiresIn,
              app_id: appId
            }
          }).done(function(data) {
            if (successCallback != null) {
              return successCallback();
            } else {
              return window.location = data.location;
            }
          });
        } else {
          return console.log('User cancelled login or did not fully authorize.');
        }
      }, {
        scope: 'email'
      });
    });
  },
  logout: function(successCallback) {
    return $.ajax('/sessions/logout', {
      type: 'DELETE',
      dataType: 'json',
      xhrFields: {
        withCredentials: true
      }
    }).done(function(data) {
      if (successCallback != null) {
        return successCallback();
      } else {
        return window.location.reload();
      }
    });
  }
};
