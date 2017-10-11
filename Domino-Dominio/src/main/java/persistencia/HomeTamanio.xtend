package persistencia


import java.util.List
import pizza.Porcion
import pizza.Chica
import pizza.Grande
import pizza.Familiar
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Tamanio
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
	List<Tamanio> tamaniosDisponibles = #[new Porcion, new Chica, new Grande, new Familiar]

	def searchTamanios(String subString) {

		if (StringUtils.isBlank(subString)) {
			tamaniosDisponibles
		} else {
			tamaniosDisponibles.filter[it.nombre.toLowerCase.contains(subString.toLowerCase)].toList
		}
	}

}
