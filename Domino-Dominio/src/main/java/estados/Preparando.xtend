package estados

import pedido.Pedido
import pedido.FormaDeRetiro
import pedido.Local
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este preparandose
//                  -Indicar cual es el siguiente o anterior estado que le sigue
@Accessors
class Preparando extends EstadoDePedido {

	FormaDeRetiro formaDeRetiro

	new() {
		formaDeRetiro = new Local
	}

	// Metodos
	override siguiente(Pedido unPedido) {
		this.formaDeRetiro = unPedido.formaDeRetiro
		unPedido.estadoActual = this.proximo
	}

	override previo() {
		this
	}

	override proximo() {
		this.formaDeRetiro.avanzarEstado
	}

	override nombre() {
		"Preparando"
	}

	override estaPreparando() { 
		true
	}

}
