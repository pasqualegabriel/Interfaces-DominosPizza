package listadoDePedidos

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import estados.EstadoDePedido
import java.util.List
import plato.PlatoAdapter
import pedido.Plato
import org.uqbar.commons.model.annotations.Dependencies
import persistencia.Home

@Accessors
@TransactionalAndObservable
class AdapterPedido 
{
	Boolean					pedidoCerrado
	Pedido 					pedidoAdaptado
	
	Integer 				nroPedido

	

	String 					estadoActual

	EstadoDePedido 			cambioDeEstado
	
	List<EstadoDePedido> 	estadosSelector  = newArrayList
	
	List<PlatoAdapter> 		platos = newArrayList
	
	PlatoAdapter 			platoSeleccionado
	
	String precio
	
	String costoDeRealizacionDeEnvioString
	double costoDeRealizacionDeEnvioInt
	new(Integer nroDePedido, Pedido unPedido, Boolean cerradoONo)

	{
		super()
		this.nroPedido		= nroDePedido
		this.pedidoAdaptado	= unPedido
		estadoActual		= unPedido.estadoActual.nombre
		cambioDeEstado		= unPedido.estadoActual
		coleccionDeEstados
		coleccionDePlatosAdapater
		costoDeRealizacionDeEnvioInt= pedidoAdaptado.formaDeRetiro.precioDeRetiro
		costoDeRealizacionDeEnvioString = "$" + pedidoAdaptado.formaDeRetiro.precioDeRetiro
		

		precio = "$" + pedidoAdaptado.calcularPrecio.toString
		pedidoCerrado	= cerradoONo

	}
	
	def void setPrecio(){
		precio = "$" + pedidoAdaptado.calcularPrecio 
	}
//	def void setPrecio(double unPrecio){
//		
//		precio= "$" +(unPrecio + costoDeRealizacionDeEnvioInt)
//		
//	}
	
	def void coleccionDePlatosAdapater() {
		
		for(Plato unPlato: pedidoAdaptado.platos){
			platos.add(new PlatoAdapter(unPlato))
		}
		
	}
	def void agregarPlatoAdapter(PlatoAdapter unPlatoAdapter)
	{	platos.add(unPlatoAdapter)	}
	
	def void coleccionDeEstados()
	{	
		this.estadosSelector = newArrayList
		//una opcion seria que los estados sepan responder si tienen siguente o anterior 
		//y controlarlos con dos if separados
		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Preparando") && !pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado"))
		{ 	estadosSelector.add(pedidoAdaptado.estadoActual.previo)	}
		estadosSelector.add(pedidoAdaptado.estadoActual)
		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado"))
		{ 	estadosSelector.add(pedidoAdaptado.estadoActual.proximo)}
	}
	
	def void pasarASiguienteEstado() 
	{
		this.pedidoAdaptado.siguiente()
		this.estadoActual = pedidoAdaptado.estadoActual.nombre
		this.coleccionDeEstados							//Refresca la lista del Selector
	}
	
	def void pasarAAnteriorEstado() 
	{
		this.pedidoAdaptado.anterior()
		this.estadoActual = pedidoAdaptado.estadoActual.nombre
		this.coleccionDeEstados							//Refresca la lista del Selector
	}
	
	def void cambiarAEstadoSeleccionado()
	{
		this.pedidoAdaptado.estadoActual = this.cambioDeEstado
		this.estadoActual = this.pedidoAdaptado.estadoActual.nombre
		
		if (this.cambioDeEstado.nombre.equalsIgnoreCase("Entregado"))
			pedidoAdaptado.calcularTiempoDeEntrega()
			Home.instance.moverPedidoAPedidosCerrado(nroPedido,pedidoAdaptado)
		
		this.coleccionDeEstados							//Refresca la lista del Selector
		this.cambioDeEstado	= pedidoAdaptado.estadoActual
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
	
	@Dependencies("precio")
	def getPrecio()
	{
		precio
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