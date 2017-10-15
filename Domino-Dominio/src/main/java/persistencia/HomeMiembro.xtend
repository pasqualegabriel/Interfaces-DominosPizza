package persistencia

import org.eclipse.xtend.lib.annotations.Accessors
import domino.Miembro
import java.util.List
import org.apache.commons.lang.StringUtils
import org.uqbar.commons.model.exceptions.UserException

@Accessors
class HomeMiembro {
	
	static HomeMiembro instance

	static def getInstance() {
		if (instance == null) {
			instance = new HomeMiembro
		}
		instance
	}
	// Estructura
	List<Miembro> miembros  = newArrayList
	
	def registrarUsuario(Miembro miembro) {
		if ( miembros.stream.anyMatch[it.nick.equals(miembro.nick)] ) throw new UserException ("El usuario ya esta registrado") 
		miembros.add(miembro)
	}
	
	def searchUsuario(String subString) {
		if (StringUtils.isBlank(subString)) {
			miembros
		} else {
			miembros.filter[it.nick.toLowerCase.contains(subString.toLowerCase)].toList
		}
	}
	
	def getMiembro (String nickDeUsuario)
	{
		var miembro = miembros.findFirst[it.nick.equals(nickDeUsuario)]
		if (miembro == null)  throw new UserException ("El usuario no existe") 
		
		miembro
	}
	
	
}