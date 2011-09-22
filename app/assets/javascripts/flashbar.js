function flashBar(text, cssClass, options) {
	$('div.flash').remove();
	var opts = $.extend({}, flashBarDefaults, options);
	flashDiv = $(document.createElement('div')).prependTo('body');
	flashDiv.html(text).addClass(cssClass).addClass('flash').fadeTo(0,0);
	flashDiv.fadeTo(opts.speed, opts.opacity);
	setTimeout(function(){
		flashDiv.fadeOut(opts.speed);
	}, opts.timeOut);
};

var flashBarDefaults = {
	timeOut: 10000,
	speed: 1000,
	opacity: 0.8
};