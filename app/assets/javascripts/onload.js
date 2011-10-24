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
	$.facebox.settings.closeImage = '/assets/facebox/closelabel.png';
	$.facebox.settings.loadingImage = '/assets/preload.gif';
	$('a[rel*=modal]').live("mousedown", function() { 
	    $(this).unbind('click'); //everytime you click unbind the past event handled.
	    $(this).facebox();
	});
	$('a[data-remote*=true]').live("click", function(){
		if ($(this).attr('walk') == 'no') {
			return false;
		} else {
			history.pushState(null, "", this.href);
			$("html, body").animate({ scrollTop: 0 }, "slow");
			return false;
		}
	});
	$(window).bind("popstate", function() {
		$.getScript(location.href);
		$("html, body").animate({ scrollTop: 0 }, "slow");
	});
	$("li.message").live({
		mouseover: function() {
			$(this).find("div.actions").show();
		},
		mouseout: function() {
			$(this).find("div.actions").hide();
		}
	});
	/*$("li.message").live("hover", function(){
		$(this).find("div.actions").show();
	},
	function() {
		$(this).find("div.actions").hide();
	}); */
	
	$('img.cap').captify({
		speedOver: 'fast',
		speedOut: 'normal',
		hideDelay: 500,	
		// 'fade', 'slide', 'always-on'
		animation: 'slide',		
		// text/html to be placed at the beginning of every caption
		prefix: '',		
		// opacity of the caption on mouse over
		opacity: '0.5',					
		// the name of the CSS class to apply to the caption box
		className: 'caption-bottom',	
		// position of the caption (top or bottom)
		position: 'top',
		// caption span % of the image
		spanWidth: '100%'
	});

});


