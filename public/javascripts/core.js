 //a class for artificially creating followers
 function Follower(realName, twitterId) {

		this.realName = new String(realName);
		this.twitterId = new String(twitterId);
}
// a class for artificially creating the icons/sprites
function Icon() {

}

function move($item,$holder) {
	$item.fadeOut(function() {
	$("br",$holder).before($item);
	$item.fadeIn();
  });
}

function sendUser(userid) {
  var $shares = new Array();

}
function getIcons (screen_name, token) {
  var getterURL = "/something.gsp";
  var conOpts = new Array();
  conOpts = {c:"icons", u:screen_name};
  $.getJSON(getterURL, conOpts /*, callback*/);


}
//had to rebuild this as a function so that when DOM was updated draggables/droppables would enable
function rebuildDD () {
  var $master = $('#master'), $slave = $('#share');
  $slave.droppable("destroy");
  $master.droppable("destroy");
  // make all sprites draggable
  $('.sprite').draggable({
		addClasses:false,
		revert: 'invalid',
		helper: 'clone',
		cursor: 'move',
		zIndex: 20,
		start: function(ev,el) {el.helper.addClass('active');},
		stop: function(ev,el) {el.helper.removeClass('active');}
  });

  // make slaves droppable accept master sprites only
  $slave.droppable({
		accept: '#master .sprite',
		zIndex: 10,
		over: function(ev,el) {$(this).addClass('hot');},
		out: function (ev,el) {$(this).removeClass("hot")},
		drop: function(ev,el) {
			move(el.draggable, $slave);
			$(this).removeClass("hot");
		}

	});

  // make master droppable accept slave sprites only
  $master.droppable({
		accept: '.sprite',
		over: function(ev,el) {$(this).addClass('hot');},
		out: function (ev,el) {$(this).removeClass("hot")},
		zIndex: 10,
		drop: function(ev, el) {
			move(el.draggable, $master);
			$(this).removeClass("hot");
		}
  });
  // close the "follower" box and return items to master vault
  $(".close").click(function(){
	var $sprites = $(this).parent().children(".sprite");
	$sprites.each(function( ){
	  move($(this),$master);
	})
	$(this).parent().fadeOut(2500).remove();
	rebuildDD();
  });
}


$(function() {
	var fTracker=0;
	var followers = new Array();
	screen_name = "jonjonsiler";
	var followerURL = "http://api.twitter.com/1/statuses/followers/" + screen_name + ".json?cursor=-1&callback=?";
		followerURL = "jonjonsiler.json";
	$.getJSON(followerURL,function(json){
	  for (i in json.users) {var f=json.users[i];$("select[name=users]").append('<option value="' + f.screen_name + '">@'+ f.screen_name + " (" + f.name + ")</option>");}
	});
	rebuildDD();
	//make a new "follower" box when the plus sign is clicked
	$('#makenew').click(function(){
	  //we need to catch for no name selected.
	  if (typeof(document.vaults.users.value) != 'undefined') {
		var newBox = new String();
		newBox  = '<div id="slave_'+ (++fTracker) +'" class="container followed">\n'; //the div id should be based on the twitterId for specificity
		newBox += '\t\t<h3>'+ document.vaults.users.value +'</h3>\n';
		newBox +=  '\t\t <div class="close">x</div>\n';
		newBox +=  '\t\t<br style="clear:left;" />\n';
		newBox +=  '\t</div>\n'
		$("#main").append(newBox);
		$("option[value="+document.vaults.users.value+"]").remove();
		rebuildDD();
		return false;
	  } else return false;
	});
	$("#vaults").submit(function(){
	  //submit post
	  alert("submitted")
	  return false;
	});
});