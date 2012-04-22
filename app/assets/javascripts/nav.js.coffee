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
    .append "<span class='up'> </span>"

  #$("ul.nav-main li span").click(->
    #$(this).parent().find("ul.subnav").slideDown("fast").show()
  #)
  $("ul.nav-main li span").click(->
    #$(this).parent().find("ul.subnav").slideDown("fast").show()
    #$(this).parent().hover (->), ->
      #$(this).parent().find("ul.subnav").slideUp "slow"

    debugger
    if $(this).hasClass('up')
      $(this).parent().find("ul.subnav").slideDown("fast").show()
      $(this).removeClass('up')
      $(this).addClass('down')
    else
      $(this).parent().find("ul.subnav").slideUp "fast"
      $(this).removeClass('down')
      $(this).addClass('up')
  )
