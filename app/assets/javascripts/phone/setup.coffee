window.F7H =
  app: new Framework7
    pushState: true
    onAjaxStart: (xhr) ->
      F7H.app.showIndicator()
    onAjaxComplete: (xhr) -> 
      F7H.app.hideIndicator()
      
  dom: Framework7.$

window.Phone =
  Views: {}

Phone.Views.Main =
  F7H.app.addView '.view-main',
    dynamicNavbar: true