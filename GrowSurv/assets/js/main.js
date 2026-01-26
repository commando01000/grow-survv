"use strict";

var PromentiumJSUtil = {

	gaugeInitCheck: function(){
		$( ".gauge-container" ).each(function(i, el){
			var $elm = $(el);
			if($elm.visible(true)){
				var $span = $elm.siblings('span');
				if($span.html() == ""){
					var total = $elm.data('total');
					var current = $elm.data('current');
					var percent = (current/total)*360;
					$elm.css("transform", "rotate(-" + percent + "deg)");
					$span.html("0");
					var val = 0;
					var id = setInterval(frame, 10);
					function frame() {
						if (val >= current) {
							clearInterval(id);
							$span.html(current); // just to be sure.
						} else {
							val+= current / 200; 
							$span.html(Math.floor(val));
						}
					}
				}
			}
		});
	},

	progressInitCheck: function(){
		$( ".progress-bar" ).each(function(i, el){
			var $elm = $(el);
			if($elm.visible(true) && $elm.css('width') == '0px'){
				var $span = $elm.children('span');
				var total = $elm.data('percentage');
				$span.html("0");
				var val = 0;
				var id = setInterval(frame, 10);
				function frame() {
					if (val >= total) {
						clearInterval(id);
						$span.html(total); // just to be sure.
					} else {
						val+= total / 100; 
						$span.html(Math.floor(val));
						$elm.css("width", Math.floor(val) + "%");
					}
				}
			}
		});
	},

	dragElementsIn: function(){
		$(".drag-this-left").each(function(i, el) {
			var el = $(el);
			if (el.visible(true)) {
				el.addClass("drag-left"); 
			} 
		});

		$(".drag-this-right").each(function(i, el) {
			var el = $(el);
			if (el.visible(true)) {
				el.addClass("drag-right"); 
			} 
		});

		$(".drag-this-up").each(function(i, el) {
			var el = $(el);
			if (el.visible(true)) {
				el.addClass("drag-up"); 
			} 
		});
	}
}

$(function(){

	PromentiumJSUtil.gaugeInitCheck();
	PromentiumJSUtil.progressInitCheck();
	PromentiumJSUtil.dragElementsIn();
	$( window ).scroll(function() {
		PromentiumJSUtil.gaugeInitCheck();
		PromentiumJSUtil.dragElementsIn();
		PromentiumJSUtil.progressInitCheck();

	});

	$(".scrolldown").on("click", function(){
		$("html,body").animate({
			scrollTop: $("header").height()
		});
	});

	var $partners = $('.slick-partners');
	var totalSlides = $partners.children().length;
	$('.slick-partners').slick({
		dots: true,
		arrows: false,
		autoplay: true,
		speed: 300,
		slidesToShow: 4,
		slidesToScroll: 1,
		responsive: [
			{
				breakpoint: 1250,
				settings: {
					dots: false
				}
			},
			{
				breakpoint: 1024,
				settings: {
					slidesToShow: 3,
					slidesToScroll: 3,
					dots: false
				}
			},
			{
				breakpoint: 600,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1,
					dots: false
				}
			}
		]
	});

	$('.header-slick').slick({
		dots: false,
		fade: true,
		arrows: false,
		autoplay: true,
		speed: 700,
		slidesToShow: 1,
		slidesToScroll: 1
	});

	$('.testimonials-slick').slick({
		dots: true,
		arrows: false,
		autoplay: true,
		speed: 300,
		slidesToShow: 3,
		slidesToScroll: 1,
		responsive: [
			{
				breakpoint: 992,
				settings: {
					slidesToShow: 2
				}
			},
			{
				breakpoint: 768,
				settings: {
					slidesToShow: 1
				}
			}

		]
	});

	$('.slick-partners .slick-dots').after('<span id="partnerSlideIndicator" data-total-slides="' + totalSlides + '">1 / ' + totalSlides + ' </span>');

	$partners.on('afterChange', function(slick, currentSlide){
		var $indicator = $('#partnerSlideIndicator');
		$indicator.html((currentSlide.slickCurrentSlide() + 1 ) + " / " + totalSlides);
	});

	$('.slick-related-projects').slick({
		dots: false,
		arrows: true,
		autoplay: true,
		speed: 300,
		slidesToShow: 4,
		slidesToScroll: 1,
		prevArrow: '<i title="Previous" class="fa fa-long-arrow-left slick-left"></i>',
		nextArrow: '<i title="Next" class="fa fa-long-arrow-right slick-right"></i>'
	});

	$('.app-feature-slick').slick({
		dots: true,
		arrows: false,
		autoplay: true,
		speed: 300,
		slidesToShow: 1,
		slidesToScroll: 1
	});


	$('.service-accordion a').on('click', function(e){
		e.preventDefault();
		$(this).closest('.service-accordion').toggleClass('expanded');
	});

	$('.slick-post').slick({
		dots: false,
		arrows: true,
		autoplay: true,
		speed: 300,
		slidesToShow: 1,
		slidesToScroll: 1,
		prevArrow: '<i title="Previous" class="fa fa-angle-left fa-lg slick-left"></i>',
		nextArrow: '<i title="Next" class="fa fa-angle-right fa-lg slick-right"></i>'
	});

	$('li.with-submenu > a').on('click', function(e){
		e.preventDefault();
		var $elm = $(this);
		if($elm.hasClass('selected')){
			$elm.removeClass('selected');
		}else{
			$elm.closest('li')
				.siblings('.with-submenu')
				.children('a')
				.removeClass('selected');

			$elm.addClass('selected');
		}
	});

	$('.social-toggle').on('click', function(e){
		e.preventDefault();
		$(this).toggleClass('open');
	});

	$('.navbar-toggler').on('click', function(e){
		e.preventDefault();
		$(this).toggleClass('clicked');
		$('.navbar-collapse').toggleClass('collapse');
	});

	$('.portfolio-nav a').on('click', function(){
		var target = $(this).data('target');
		var $prev = $('.portfolio-browse.active');
		$prev.removeClass('active');
		$prev.fadeOut(200,function(){
			$(target).fadeIn().addClass('active') ;	
		});
		
	});

});