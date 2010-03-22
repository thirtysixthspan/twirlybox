
function move($item,$holder) {
	$item.fadeOut(function() {
		$("br",$holder).before($item);
		$item.fadeIn();
  });
}

//had to rebuild this as a function so that when DOM was updated draggables/droppables would enable
function rebuildDD () {
  var $vault = $('#vault');
  var $store = $('#store');
  var $friends = $('#friends');

  $vault.droppable("destroy");
  $store.droppable("destroy");

  // make all sprites draggable
  $('.sprite').draggable({
		addClasses: false,
		revert: 'invalid',
		helper: 'clone',
		cursor: 'move',
		zIndex: 20,
		start: function(ev,el) {el.helper.addClass('active');},
		stop: function(ev,el) {el.helper.removeClass('active');}
  });

  // make all sprites draggable
  $('.friend').draggable({
		addClasses: false,
		revert: 'invalid',
		helper: 'clone',
		cursor: 'move',
		zIndex: 20,
		start: function(ev,el) {el.helper.addClass('active');},
		stop: function(ev,el) {el.helper.removeClass('active');}
  });

  $vault.droppable({
		accept: '.sprite',
		zIndex: 10,
		over: function(ev,el) {$(this).addClass('hot');},
		out: function (ev,el) {$(this).removeClass('hot')},
		drop: function(ev,el) {
			move(el.draggable, $vault);
			$(this).removeClass("hot");
		}

	});

}


$(function() {
	screen_name = $('#user_name').html();
	var friendsURL = "http://api.twitter.com/1/statuses/friends/" + screen_name + ".json?cursor=-1&callback=?";
	$.getJSON(friendsURL,function(json){
    $("#friends_bin").append("<div class='friend'>TEST</div>")
	  for (i in json.users) {
      var d = document.createElement('div');
      d.className = 'friend sprite';
      var img = document.createElement('img');
      img.setAttribute("width", "75");
      img.setAttribute("src", json.users[i].profile_image_url);
      $(d).append(img)
      t = document.createTextNode(json.users[i].screen_name);
      $(d).append(t);
      $(d).insertAfter($("#friends_bin"));
      $(d).droppable({
				accept: '.sprite',
				zIndex: 50,
				over: function(ev,el) {$(this).addClass('enlarge');},
				out: function (ev,el) {$(this).removeClass('enlarge')},
				drop: function(ev, el) {
					$(this).removeClass("enlarge");
					move(el.draggable, $friends);
				}
		  });
		}
	});
	
	rebuildDD();

});


