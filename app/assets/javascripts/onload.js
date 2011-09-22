$(document).ready(function(){ 
  $('ul.menu').superfish({
    animation:   {height:'show'},
    speed:         'fast',
    autoArrows:  true,
    dropShadows: true
    });
	$.facebox.settings.closeImage = '/assets/facebox/closelabel.png';
	$.facebox.settings.loadingImage = '/assets/preload.gif';
	
	$('a[rel*=modal]').facebox();
});