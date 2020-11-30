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

$('#follow-list').on('click', function() {
	if(myID == "null") {
		alert("로그인이 필요한 기능입니다.");
	}
	else{
		$('#follow-list-modal').modal({ fadeDuration: 100 });
		$('#sidebar').removeClass('active');
		$('.overlay').fadeOut();
		var id = encodeURIComponent(myID);
		var url = "follow/follow-list-db.jsp?myID="+id;

		$.ajax({
			type: "GET",
			url : url,
			dataType : "html",
     		error:function(request,status,error){
        		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       		},
			success : function(data) {
				$("#follow-list-result").html(data);
			}
		});
	}
});

$(document).on('click', ".follow-btn", (e) => { 
	var targetID = e.target.value;
	//myID는 calendar.jsp에 상단 script에 선언
	var url = "follow/follow-db.jsp?myID="+myID+"&targetID="+targetID; 
	window.location.href=url;
});
