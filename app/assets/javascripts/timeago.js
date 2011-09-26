function time_ago_in_words(from) {

	var now = new Date().getTime();
	seconds_ago = (now / 1000) - from;
	minutes_ago = Math.floor(seconds_ago / 60);

	if(minutes_ago == 0) { return "less than a minute"; }
	if(minutes_ago == 1) { return "a minute"; }
	if(minutes_ago < 45) { return minutes_ago + " minutes"; }
	if(minutes_ago < 90) { return " about 1 hour"; }
	hours_ago  = Math.round(minutes_ago / 60);
	if(minutes_ago < 1440) { return "about " + hours_ago + " hours"; }
	if(minutes_ago < 2880) { return "1 day"; }
	days_ago  = Math.round(minutes_ago / 1440);
	if(minutes_ago < 43200) { return days_ago + " days"; }
	if(minutes_ago < 86400) { return "about 1 month"; }
	months_ago  = Math.round(minutes_ago / 43200);
	if(minutes_ago < 525960) { return months_ago + " months"; }
	if(minutes_ago < 1051920) { return "about 1 year"; }
	years_ago  = Math.round(minutes_ago / 525960);
	return "over " + years_ago + " years";
}