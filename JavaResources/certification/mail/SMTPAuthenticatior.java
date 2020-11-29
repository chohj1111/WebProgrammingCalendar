package certification.mail;
import javax.mail.*;

public class SMTPAuthenticatior extends Authenticator{	
	@Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("webcalendar12@gmail.com","aa33229988--");
    }
}
