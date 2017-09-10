package estados

import pedido.Pedido

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este este listo para retirar
//                  -Indicar cual es el siguiente o anterior estado que le sigue
class ListoParaRetirar extends EstadoDePedido {

	// Metodos
	override siguiente(Pedido unPedido) {
		var estadoSiguiente = this.proximo()
		unPedido.estadoActual = estadoSiguiente
		unPedido.calcularTiempoDeEntrega()
	}

	override proximo() {
		new Entregado
	}

	override previo() {

		new Preparando
	}
	
	override nombre() {
		"Listo para retirar"
	}

}
