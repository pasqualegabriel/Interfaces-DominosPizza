package listadoDePedidos

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import estados.EstadoDePedido
import java.util.List
import plato.PlatoAdapter
import estados.Entregado
import estados.Preparando
import estados.Cancelado
import estados.EnViaje
import estados.ListoParaEnviar
import estados.ListoParaRetirar
import pedido.Plato

@Accessors
@TransactionalAndObservable
class AdapterPedido 
{
	Pedido pedidoAdaptado
	Integer nroPedido
	EstadoDePedido estadoActual
	EstadoDePedido cambioDeEstado
	List<EstadoDePedido> estadosSelector  = newArrayList
	List<PlatoAdapter> 		platos = newArrayList
	PlatoAdapter platoSeleccionado
	String precio
	
	new(Integer nroDePedido, Pedido unPedido)
	{
		super()
		this.nroPedido		= nroDePedido
		this.pedidoAdaptado	= unPedido
		estadoActual= unPedido.estadoActual
		coleccionDeEstados
		coleccionDePlatosAdapater
		precio = "$" + pedidoAdaptado.calcularPrecio.toString
		
	}
	
	def void coleccionDePlatosAdapater() {
		
		for(Plato unPlato: pedidoAdaptado.platos){
			platos.add(new PlatoAdapter(unPlato))
		}
		
	}
	
	def void coleccionDeEstados() {
		estadosSelector.add(new Entregado)
		estadosSelector.add(new Preparando)
		estadosSelector.add(new Cancelado)
		estadosSelector.add(new EnViaje)
		estadosSelector.add(new ListoParaEnviar)
		estadosSelector.add(new ListoParaRetirar)
	}
	
	def getEstadoActual() {
		estadoActual.nombre
	}
	
	def void pasarASiguienteEstado() 
	{
		this.pedidoAdaptado.siguiente()
		this.estadoActual = pedidoAdaptado.estadoActual
	}
	
	def void pasarAAnteriorEstado() 
	{
		this.pedidoAdaptado.anterior()
		this.estadoActual = pedidoAdaptado.estadoActual
	}
	
	def void cancelar()
	{
		this.pedidoAdaptado.cancelar
	}	

	def getHora()
	{
		pedidoAdaptado.fecha.toLocalTime.hour.toString + ":" + pedidoAdaptado.fecha.toLocalTime.minute.toString
	}
	
	def getNombre()
	{
		"Pedido "+this.nroPedido
	}
	
	def getNombreDeEstado()
	{
		pedidoAdaptado.estadoActual.nombre
	}
	
	def getPrecio()
	{
		this.pedidoAdaptado.calcularPrecio
	}
	
	def getFecha()
	{
		this.pedidoAdaptado.fecha.toLocalDate
	}
	
	def getTiempoDeEspera()
	{
		if (this.pedidoAdaptado.tiempoDeEspera == 0)
			"-"
		else 
			this.pedidoAdaptado.tiempoDeEspera.toString + " Minutos"
	}
	
}