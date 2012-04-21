$(document).ready ->

  $("#playlist_create_link")
    .click (evt) ->
      $(@).hide()
      $("#new_playlist").fadeIn()

  $("#new_playlist")
    .bind "ajax:success", (evt, data) ->
      $(@).hide()
      $("#playlist_create_link").fadeIn()

  $("ul.subnav").parent()
    .append "<span> </span>"

  $("ul.topnav li span").click(->
    $(this).parent().find("ul.subnav").slideDown("fast").show()
    $(this).parent().hover (->
    ), ->
      $(this).parent().find("ul.subnav").slideUp "slow"
  )
