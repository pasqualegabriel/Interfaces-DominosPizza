package persistencia

import java.util.List
import domino.Login

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
	
}