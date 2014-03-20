/**
 * Demo #1 Javascript
 */
$( document ).ready(function() {
	$('#demo1').fadeThrough({});
});

/**
 * Demo #2 Javascript
 */
$( document ).ready(function() {
	$('#demo2').fadeThrough({
		interval: 5000,
		fadeduration: 1000,
		heightduration: 300,
		animatestartheight: true,
		autostart: true,
		childIdentifier: 'li'
	});
});

/**
 * Demo #3 Javascript
 */
$( document ).ready(function() {
	$('#demo3').fadeThrough({
		autostart: false
	});
});