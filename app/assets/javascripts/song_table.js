$(document).ready(function(){
  $("#jquery_jplayer_1").jPlayer(
    {
      ready: function(){
        // Attempt to auto play the media

      },
      supplied: "mp3"
    });
    var CLIENT_ID = "8d4242fa1237419ca04ec11eb51007c0";

    $(".play_button").click(function(){
      var url = $(this).attr("id");
      $("#jquery_jplayer_1").jPlayer(
      "setMedia",{mp3: url + "?client_id=" + CLIENT_ID}).jPlayer("play");
    });
});
