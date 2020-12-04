// import momentjs
var momentJS = document.createElement('script');  
momentJS.setAttribute('src','https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js');
document.head.appendChild(momentJS);

// notification in calendar 
// check if requestPermission 
// true : promise-based syntax(latest)
// false : old,deprecated(eg : safari )


// calendar
document.addEventListener('DOMContentLoaded', function() {
	 if (window.Notification && Notification.permission !== "granted") {
    Notification.requestPermission(function (status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      		}
    	});
  	}
	var calendarEl = document.getElementById('calendar');
	// to get id from event 
	var event_id;
	calendar = new FullCalendar.Calendar(calendarEl, {
		customButtons: {
			sidebarButton: {
				text: '☰',
				click: function() {
					$('#sidebar').addClass('active');
					$('.overlay').fadeIn();
				}
			}
		},
		headerToolbar: {
			left: 'sidebarButton prevYear,prev,next,nextYear today',
			center: 'title',
			right: 'dayGridMonth,dayGridWeek,dayGridDay'
		},
		locale: 'ko',
		navLinks: true, // can click day/week names to navigate views
		editable: true,
		dayMaxEvents: true, // allow "more" link when too many events

		initialView: 'dayGridMonth',
		selectable: true,
		editable: true,
		eventResizableFromStart :true,
		droppable: true,
		events: 'calendarjson.jsp',

		// drop within calendar
		// there is no need to modify color or memo(description) 
		eventDrop: function (info) {
			var start_moment = moment(info.event.start);
			var end_moment = moment(info.event.end);
			//일정이 2일 이상일 경우 종료일에서 하루 더 추가 (full calendar 문제인듯)
			if (!start_moment.isSame(end_moment,'day')) {
				end_moment = end_moment.subtract(1, "days");
			}
			var startdateString =  start_moment.format('YYYY-MM-DD');
			var enddateString = end_moment.format('YYYY-MM-DD');
			
						
			$.ajax({
            	url:'../CalendarAjax',
				type    : 'post',
				dataType: 'json',
                data    : {
                   	id: info.event.id,
        			title: info.event.title,
        			startdate: startdateString,
        			enddate: enddateString   
                },    	   
    	        success: function(result) { //we got the response
             		//alert('Successfully called');
       			  }	,
         		error: function(jqXHR, textStatus, errorThrown) {
              		console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
         		}

	       });

		  calendar.render();
		  location.reload();
		},
		
		//resize는 end date 조정 필요 x 
		eventResize: function (info) {
			var start_moment = moment(info.event.start);
			var end_moment = moment(info.event.end);
			//일정이 2일 이상일 경우 종료일에서 하루 더 추가 (full calendar 문제인듯)
			if (!start_moment.isSame(end_moment,'day')) {
				end_moment = end_moment.subtract(1, "days");
			}
			var startdateString =  start_moment.format('YYYY-MM-DD');
			var enddateString = end_moment.format('YYYY-MM-DD');
						
			$.ajax({
            	url:'../CalendarAjax',
				type    : 'post',
				dataType: 'json',
                data    : {
                   	id: info.event.id,
        			title: info.event.title,
        			startdate: startdateString,
        			enddate: enddateString   
                },    	   
    	        success: function(result) { //we got the response
             	//	alert('Successfully called');
       			  }	,
         		error: function(jqXHR, textStatus, errorThrown) {
              		console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
         		}

	       });

		  calendar.render();
		  location.reload();
		},
		
					
		dateClick: function(info) {
			$("#addEvent-modal").modal({ fadeDuration: 100 });
			$("#input-start").val(info.dateStr);
			$("#input-end").val(info.dateStr);
		},

		eventClick: function(info) {
			edit_event = info.event;
			//get id of event
			event_id = info.event.id;
			
			$("#editEvent-modal").modal({ fadeDuration: 100 });
			$("#edit-title").val(info.event.title);
			$("#edit-color").val(info.event.backgroundColor).prop("selected", true);
			$("#edit-start").val(info.event.startStr);
			
			if (!info.event.endStr) {
				$("#edit-end").val(info.event.startStr);
			}
			else {
				var start = new Date(info.event.startStr);
				var end = new Date(info.event.endStr);
				if (start.getTime() != end.getTime()) {
					end.setDate(end.getDate() - 1);
				}
				$("#edit-end").val(end.toISOString().split('T')[0]);
				
			}
			$("#edit-memo").text(info.event.extendedProps.description);
			
		},

	});

	//일정 추가
	$('#input-save').on('click', function(e) {
		e.preventDefault();
		var title = $("#input-title").val();
		var color = $("#input-color").val();
		var start = new Date($("#input-start").val());
		var end = new Date($("#input-end").val());
		var memo = $("#input-memo").val();
		
		//일정이 2일 이상일 경우 종료일에서 하루 더 추가 (full calendar 문제인듯)
		if (start.getTime() != end.getTime()) {
			end.setDate(end.getDate() + 1);
		}

		calendar.addEvent({
			title: title,
			start: start,
			end: end,
			color: color,
			description: memo,
			allDay: true
		});

		$.modal.close()
     	$('#calendar_insert_form').submit(); 
    
	});

	// 일정 수정
	$('#edit-save').on('click', function(e) {
		e.preventDefault();
		edit_event.remove();
		var title = $("#edit-title").val();
		var color = $("#edit-color").val();
		var start = new Date($("#edit-start").val());
		var end = new Date($("#edit-end").val());
		var memo = $("#edit-memo").val();
		if (start.getTime() != end.getTime()) {
			end.setDate(end.getDate() + 1);
		}

		calendar.addEvent({
			title: title,
			start: start,
			end: end,
			color: color,
			description: memo,
			allDay: true
		});
		//change form action to 'calendar-modify-db.jsp'
		$('#calendar_modify_form').attr('action', 'calendar-db/calendar-modify-db.jsp');
		$('#calendar_modify_form').append('<input type="hidden" name="id" value="'+ String(event_id)+'"/>');
		$.modal.close();
		$('#calendar_modify_form').submit(); 
	});

	// 일정 삭제
	$('#edit-delete').on('click', function(e) {
		e.preventDefault();
		edit_event.remove();
		
		//change form action to 'calendar-modify-db.jsp'
		$('#calendar_modify_form').attr('action', 'calendar-db/calendar-delete-db.jsp');
		$('#calendar_modify_form').append('<input type="hidden" name="id" value="'+ String(event_id)+'"/>');
		$.modal.close()
		$('#calendar_modify_form').submit(); 
	});
	
	$('#search-submit').click(function(){
		$('#search_frame').css("display","block");
	});
	
	$("#frame_close_btn").click(function(){
		$('#search_frame').css("display","none");
	});
	
	$('#notice_btn').click(function(){
		if($('#notice_frame').css("display") == "none"){
			$('#notice_frame').css("display","block");
		}else{
			location.reload();
			$('#notice_frame').css("display","none");
		}
	});
	
	if($('#notice_num').text() != "0")
		$('#notice_num').css("display","block");
	else{
		$('#notice_num').css("display","none");
	}
	
	var currentdate = calendar.getDate();
	calendar.gotoDate(currentdate);

	calendar.render();
});

