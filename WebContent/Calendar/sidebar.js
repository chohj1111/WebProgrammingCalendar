//사이드바 사리지기
$('.overlay').on('click', function() {
	$('#sidebar').removeClass('active');
	$('.overlay').fadeOut();
});

//로그아웃
$('#logout').on('click', function() {
	window.location.href="sidebar-action.jsp?act=logout";
});
	
//사용자 검색 창 오픈
$('#user-search').on('click', function() {
	$("#user-search-modal").modal({ fadeDuration: 100 });
	$('#sidebar').removeClass('active');
	$('.overlay').fadeOut();
});

//사용자 검색
$('#user-search-btn').on('click', function() {
	var username = $("#username-input").val();
	username = encodeURIComponent(username);
	var url = "sidebar-action.jsp?act=search&username="+username;
	$.ajax({
		cache: false,
		type: "GET",
		url : url,
		dataType : "html",
		error : function() {
			alert("ajax error");
		},
		success : function(data) {
			$("#user-search-result").html(data);
		}
	});
});