package persistencia

import org.eclipse.xtend.lib.annotations.Accessors
import domino.Miembro
import java.util.List
import org.apache.commons.lang.StringUtils

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
		miembros.add(miembro)
	}
	
	def searchUsuario(String subString) {
		if (StringUtils.isBlank(subString)) {
			miembros
		} else {
			miembros.filter[it.nombre.toLowerCase.contains(subString.toLowerCase)].toList
		}
	}
	
	def getMiembro (String nombreDeUsuario)
	{
		miembros.findFirst[it.nombre.equals(nombreDeUsuario)]
	}
	
	def modificarMiembroPorEjemplo(Miembro miembroMuestra, Miembro miembroAModificar) {
		miembroAModificar.nombre   =miembroMuestra.nombre
		miembroAModificar.direccion=miembroMuestra.direccion
		miembroAModificar.mail     =miembroMuestra.mail
	}
	
	
}