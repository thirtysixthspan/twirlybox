
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

  //if dropping sprites from the store we need to limit the accept selector to #store .sprite
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

function loadFriends(cur){
	screen_name = $('#user_name').html();
	var friendsURL = "http://api.twitter.com/1/statuses/friends/" + screen_name + ".json?cursor=" + cur + "&callback=?";
	$(".friend, .next, .prev").fadeOut().remove();
	$.getJSON(friendsURL,function(json){
	  if (json.next_cursor > 0) {
		var next = document.createElement('div');
		$(next).addClass("next");
		$(next).append('<a onclick="loadFriends('+ json.next_cursor +'); return false;" href="">next</a>');
		$(next).appendTo($("#friends_bin"));
	  }

	  for (i in json.users) {
		var d = document.createElement('div');
		d.className = 'friend';
		d.id = json.users[i].screen_name; //add a unique friend identifier
		var img = document.createElement('img');
		img.setAttribute("width", "75");
		img.setAttribute("src", json.users[i].profile_image_url);
		$(d).append(img)
		t = document.createTextNode(json.users[i].screen_name);
		$(d).append(t);
		$(d).hide().insertAfter($("#friends_bin")).fadeIn();
		//if there is a next cursor add it here?
		$(d).droppable({
			accept: '.sprite',
			zIndex: 50,
			over: function(ev,el) {$(this).addClass('enlarge');},
			out: function (ev,el) {$(this).removeClass('enlarge')},
			drop: function (ev,el) {
			  $(this).removeClass("enlarge");
			  var option={itemid:el.draggable.attr("id"), userid:$(this).attr("id")};
			  //include the send function in the drop queue
			  sendItem(option);
			  el.draggable.fadeOut().remove();
			  el.helper.fadeOut().remove(); //we can eliminate this step by changing the draggable helper to "original"
			}
		});
	  }
	  if (json.previous_cursor < 0) {
		var prev = document.createElement('div');
		$(prev).addClass('prev');
		$(prev).append('previous');
		$(prev).insertAfter($("#friends_bin"));
	  }
	  
	});

	rebuildDD();
}
/*
 *the function that is called when a draggable is dropped on a follower
 *expects Object
 *returns boolean ?mixed for error control?
 */
function sendItem (el) {
  //here we want to sanitze the input, I suppose grab our session or form "token" and enclose it in a post
  $.post( "vault/send/", el, function(data) {/*alert("Congrats");*/} );
  return true;
}

$(function() {
	loadFriends(-1);
});


