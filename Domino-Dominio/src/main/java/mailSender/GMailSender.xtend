package mailSender

import java.util.Properties
import javax.mail.Authenticator
import javax.mail.Message
import javax.mail.MessagingException
import javax.mail.PasswordAuthentication
import javax.mail.Session
import javax.mail.Transport
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeMessage
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class GMailSender {

	Integer                    id
	UserPasswordAuthentication authentication

	new(String username, String password) {
		authentication = new UserPasswordAuthentication(username, password)
	}
	
	static GMailSender instance
	
	static def instance() { instance }
	
	static def config(GMailSender sender) { 
		instance = sender
	}

	def sendMail(String to, String subject, String text) {

		try {
			val message = new MimeMessage(createSession)
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to))
			message.subject = subject
			message.text = text

			Transport.send(message)

		} catch (MessagingException e) {
			e.printStackTrace
			throw e
		}
	}

	private def createSession() {
		val props = new Properties => [
			put("mail.smtp.auth", "true")
			put("mail.smtp.starttls.enable", "true")
			put("mail.smtp.host", "smtp.gmail.com")
			put("mail.smtp.port", "587")
		]

		Session.getInstance(props, authentication)
	}
}

@Accessors
class UserPasswordAuthentication extends Authenticator {

	Integer id
	String username
	String password

	new(String _username, String _password) {
		username = _username
		password = _password
	}

	override protected getPasswordAuthentication() { 
		new PasswordAuthentication(username, password)
	}

}
