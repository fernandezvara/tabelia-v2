$(document).ready(function(){ 
  $('ul.menu').superfish({
    animation:   {height:'show'},
    speed:         'fast',
    autoArrows:  true,
    dropShadows: false
    });
	$.facebox.settings.closeImage = '/assets/facebox/closelabel.png';
	$.facebox.settings.loadingImage = '/assets/preload.gif';
	/* $('a[rel*=modal]').facebox(); */
	$('a[rel*=modal]').live("mousedown", function() { 
	    $(this).unbind('click'); //everytime you click unbind the past event handled.
	    $(this).facebox();
	});
	$('a[data-remote*=true]').live("click", function(){
		if ($(this).attr('walk') == 'no') {
			return false;
		} else {
			history.pushState(null, "", this.href);
			return false;
		}
	});
	$(window).bind("popstate", function() {
		$.getScript(location.href);
	});
	$("li.message").hover(function(){
		$(this).find("div.actions").show();
	},
	function() {
		$(this).find("div.actions").hide();
	});
});


