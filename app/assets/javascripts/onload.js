$(document).ready(function(){ 

	$.facebox.settings.closeImage = '//s3-eu-west-1.amazonaws.com/assets.tabelia.com/assets/facebox/closelabel.png';
	$.facebox.settings.loadingImage = '//s3-eu-west-1.amazonaws.com/assets.tabelia.com/assets/preload.gif';
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
	$('div#spotlight').cycle({
		fx: 'fade',
		timeout: 10000,
		speed: 500,
		pause: 0,
		cleartype: true,
		cleartypeNoBg: true
	});
	
});

$(window).load(function(){  
	$.each($('body').find("img.item"), function() {
		var parent_height = $(this).parent().parent().height();
	    var image_height = $(this).height();  
	    var top_margin = (parent_height - image_height)/2 - 5;  
	    $(this).css( 'margin-top' , top_margin);
	});
});

