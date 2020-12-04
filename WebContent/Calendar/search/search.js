$(document).ready(function(){
	$(".title").click(function(){
		if($(this).next(".li_memo").css("display") == "none"){
			$(this).next(".li_memo").css("display","block");
		}else{
			$(this).next(".li_memo").css("display","none");
		}
	});
});