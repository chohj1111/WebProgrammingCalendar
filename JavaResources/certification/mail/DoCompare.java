package certification.mail;

public class DoCompare {
	
	private static String code = "1234";
	private static String userInput = "213";
	
	public static void setCode(String input) {
		code = input;
	}
	
	public static void setInput(String input) {
		userInput = input;
	}
	
	public static String getCode() {
		return code;
	}
	
	public static String getInput() {
		return userInput;
	}
	
	public boolean doCompare(){
		if(code.equals(userInput))
			return true;
		else
			return false;
	}
}
