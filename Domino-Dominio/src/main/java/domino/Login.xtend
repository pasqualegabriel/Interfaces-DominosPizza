package domino

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Login {
	String nick
	String password 
	
	new(){}
	
	new(String unUsuario, String unPassword){
		nick= unUsuario
		password= unPassword
	}
}