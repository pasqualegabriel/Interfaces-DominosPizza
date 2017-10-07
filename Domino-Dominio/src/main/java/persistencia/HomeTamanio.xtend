package persistencia


import java.util.List
import pizza.Porcion
import pizza.Chica
import pizza.Grande
import pizza.Familiar
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Tamanio2

@Accessors
class HomeTamanio {

	static HomeTamanio instance

	static def getInstance() {
		if (instance == null) {
			instance = new HomeTamanio()
		}
		instance
	}

	// Estructura
	List<Tamanio2> promocionesDisponibles = #[new Porcion, new Chica, new Grande, new Familiar]

	def searchTamanios(String subString) {

		if (StringUtils.isBlank(subString)) {
			promocionesDisponibles
		} else {
			promocionesDisponibles.filter[it.nombre.toLowerCase.contains(subString.toLowerCase)].toList
		}
	}

}
