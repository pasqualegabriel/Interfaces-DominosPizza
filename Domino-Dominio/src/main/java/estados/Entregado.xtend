package estados

import pedido.Pedido

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de este estado
class Entregado extends EstadoDePedido {

	// Metodos
	override cancelar(Pedido unPedido)
	{	}
	
	override proximo() {
		this
	}
	
	override previo() {
		this
	}
	
	override nombre() {
		"Entregado"
	}
	
	override estaCerrado()
	{
		true
	}
	
	override estaEntregado()
	{
		true
	}
	
}
