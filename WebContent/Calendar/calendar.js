document.addEventListener('DOMContentLoaded', function() {
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
		droppable: true,
		events:  /* [{"title":"event1","start":"2020-11-27","end":"2020-11-27"}]*/
		'calendarjson.jsp',

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
			$("#edit-color").val(info.event.color);
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
		//check required attribute	
		for(var i=0; i < $('#calendar_modify_form').elements.length; i++){
      		if($('#calendar_modify_form').elements[i].value == '' 
				&& $('#calendar_modify_form').elements[i].hasAttribute('required')){
			        alert('There are some required fields!');
        			return false;
      			}
    	}
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

	//사이드바 사리지기
	$('.overlay').on('click', function() {
		$('#sidebar').removeClass('active');
		$('.overlay').fadeOut();
	});

	var currentdate = calendar.getDate();
	calendar.gotoDate(currentdate);

	calendar.render();
});

