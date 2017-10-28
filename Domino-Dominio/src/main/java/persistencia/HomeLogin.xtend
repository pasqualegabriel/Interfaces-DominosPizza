package persistencia

import java.util.List
import domino.Login
import org.uqbar.commons.model.exceptions.UserException

class HomeLogin {
	static HomeLogin instance

	static def getInstance() {
		if (instance == null) {
			instance = new HomeLogin
		}
		instance
	}
	// Estructura
	List<Login> logins  = newArrayList
	
	def registrarLogin(Login unLogin) {
		logins.add(unLogin)
	}
	
	def verificarLogin(Login unLogin) 
	{
		var miembro = HomeMiembro.instance.getMiembro(unLogin.nick)
		if ( miembro.password.equals(unLogin.password))
		{	return miembro	}
		else
		{ throw new UserException ( "La contraseña es incorrecta")}
	}
	
}