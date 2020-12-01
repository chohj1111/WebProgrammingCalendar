// import momentjs
var momentJS = document.createElement('script');  
momentJS.setAttribute('src','https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js');
document.head.appendChild(momentJS);

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('f-calendar');
	// to get id from event 
	var event_id;
	
	var json_url = "follow-calendarjson.jsp?id="+targetID;
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
		events:  /* [{"title":"event1","start":"2020-11-27","end":"2020-11-27"}]*/
		json_url
	});
	
	var currentdate = calendar.getDate();
	calendar.gotoDate(currentdate);

	calendar.render();
});

