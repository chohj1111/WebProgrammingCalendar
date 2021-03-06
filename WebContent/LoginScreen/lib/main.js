if(/MSIE \d|Trident.*rv:/.test(navigator.userAgent)) {
	setTimeout(function() {
		window.location = 'microsoft-edge:' + window.location;
		window.location = 'https://go.microsoft.com/fwlink/?linkid=2135547';
	}, 1);
}
  
$(document).ready(function () {
    $(".animated-text").typed({
        strings: [
            "더 쉬운 캘린더",
            "더 빠른 캘린더",
            "더 효율적인 캘린더"
        ],
        typeSpeed: 70,
        backSpeed: 35,
        backDelay: 900,
        loop: true,
    });

    $("#owl-lib").owlCarousel({
        autoPlay: 1800,
        items: 4,
        itemsDesktop: [1200, 3],
        itemsDesktopSmall: [800, 3],
        dragEndSpeed: 1
    });
});