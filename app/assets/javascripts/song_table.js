$(document).ready(function(){
  $("#jquery_jplayer_1").jPlayer(
    {
      ready: function(){
        // Attempt to auto play the media

      },
      supplied: "mp3",
      swfPath: "/js",
      solution: "html, flash"
    });
    var CLIENT_ID = "8d4242fa1237419ca04ec11eb51007c0";

    $(".play_button").click(function(){
      if($(this).hasClass("not-playing"))
      {
        var url = $(this).attr("id");
        $("#jquery_jplayer_1").jPlayer(
        "setMedia",{mp3: url + "?client_id=" + CLIENT_ID}).jPlayer("play");
        $(this).removeClass("not-playing");
        $(this).addClass("playing");
      }
      else if ($(this).hasClass("playing"))
      {
        $("#jquery_jplayer_1").jPlayer("pause");
        $(this).removeClass("playing");
        $(this).addClass("paused");
      }
      else {
        $("#jquery_jplayer_1").jPlayer("play");
        $(this).removeClass("paused");
        $(this).addClass("playing");
      }
    });
});
