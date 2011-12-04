$(document).ready(function(){ 
  $('ul.menu').superfish({
    animation:   
		{
			height:'show'
		},
    speed:         'fast',
    autoArrows:  true,
    dropShadows: false
    });
	$.facebox.settings.closeImage = 'http://assets.tabelia.com/assets/facebox/closelabel.png';
	$.facebox.settings.loadingImage = 'http://assets.tabelia.com/assets/preload.gif';
	$('a[rel*=modal]').live("mousedown", function() { 
	    $(this).unbind('click'); //everytime you click unbind the past event handled.
	    $(this).facebox();
	});
	$('a[data-remote*=true]').live("click", function(e){
		if ($(this).attr('walk') == 'no') {
			e.preventDefault();
		} else {
			history.pushState(null, "", this.href);
			$("html, body").animate({ scrollTop: 0 }, "slow");
			e.preventDefault();
		}
	});

	$("li.message").live({
		mouseover: function() {
			$(this).find("div.actions").show();
		},
		mouseout: function() {
			$(this).find("div.actions").hide();
		}
	});
	$("time.timeago, time.timeagoright").timeago();
	$("img.tip").tipsy({
	  live: true,
	  trigger: 'hover',
	  gravity: 'w'
	});
	
	
	
});


