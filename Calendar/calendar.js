document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');

	calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prevYear,prev,next,nextYear today',
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
		//events: []


		dateClick: function(info) {
			$("#addEvent-modal").modal({ fadeDuration: 100 });
			$("#input-start").val(info.dateStr);
			$("#input-end").val(info.dateStr);
		},

		eventClick: function(info) {
			edit_event = info.event;
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

		$.modal.close()
	});

	// 일정 삭제
	$('#edit-delete').on('click', function(e) {
		e.preventDefault();
		edit_event.remove();

		$.modal.close()
	});

	var currentdate = calendar.getDate();
	calendar.gotoDate(currentdate);

	calendar.render();
});

