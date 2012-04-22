$(document).ready ->

  $("#playlist_create_link")
    .click (evt) ->
      $(@).hide()
      $("#new_playlist").fadeIn()

  $("#new_playlist")
    .bind "ajax:success", (evt, data) ->
      $(@).hide()
      $("#playlist_create_link").fadeIn()

  #$("ul.subnav").parent()
    #.append "<span class='up'> </span>"

  #$("ul.nav-main li span").click(->
    #$(@).parent().find("ul.subnav").slideDown("fast").show()
  #)
  $("ul.nav-main li span").click(->
    #$(@).parent().find("ul.subnav").slideDown("fast").show()
    #$(@).parent().hover (->), ->
      #$(@).parent().find("ul.subnav").slideUp "slow"

    if $(@).hasClass('up')
      $(@).parent().find("ul.subnav").slideDown("fast").show()
      $(@).removeClass('up')
      $(@).addClass('down')
    else
      $(@).parent().find("ul.subnav").slideUp "fast"
      $(@).removeClass('down')
      $(@).addClass('up')
  )
