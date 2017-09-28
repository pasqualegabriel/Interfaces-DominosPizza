package testAppModels

import static org.junit.Assert.*
import org.junit.Test
import org.junit.Before
import plato.PlatoAppModel
import pedido.Plato
import pizza.Pizza
import pizza.Distribucion
import pizza.Ingrediente
import pizza.Grande
import plato.IngredienteExtraAppModel
import pizza.DistribucionEnPizza

class PlatoAppModelTest 
{

	PlatoAppModel  		elPlatoDePrueba
	Plato				unPlato
	Pizza           	unaPizza
	Ingrediente 		salame
	Ingrediente			morron
	IngredienteExtraAppModel	salameAdapter
	IngredienteExtraAppModel	morronAdapter

	@Before
	def void SetUp()
	{
		morron 			= new Ingrediente("Morron", 5.0)
		salame 			= new Ingrediente("Salame", 15.0)
		unaPizza		= new Pizza("De Cancha", 85.0, new Distribucion)
		unPlato			= new Plato(unaPizza, new Grande, new Distribucion)
		elPlatoDePrueba	= new PlatoAppModel(unPlato)
		salameAdapter	= new IngredienteExtraAppModel(elPlatoDePrueba,salame)
		morronAdapter	= new IngredienteExtraAppModel(elPlatoDePrueba,morron)
	}

	@Test
	def Un_Plato_Sin_Ingredientes_Extras_Y_Como_Pizza_Una_De_Precio_Base_85_Su_Calculo_De_Precio_Es_85()
	{
		//Exercise
		elPlatoDePrueba.calcularPrecio
		//test
		assertEquals(85.0, elPlatoDePrueba.precio ,0.001)
	}
	
	@Test
	def Un_Plato_Al_Agregarle_Dos_Ingredientes_Extras_Su_Precio_Sube_A_105()
	{
		//Setup
		morronAdapter.activado = true
		morronAdapter.distribucionSeleccionada = DistribucionEnPizza.Toda
		salameAdapter.activado = true
		salameAdapter.distribucionSeleccionada = DistribucionEnPizza.Toda
		
		//Exercise
		elPlatoDePrueba.ingredientesExtras.add(morronAdapter)
		elPlatoDePrueba.ingredientesExtras.add(salameAdapter)
		elPlatoDePrueba.calcularPrecio
		
		//test
		assertEquals(105.0, elPlatoDePrueba.precio ,0.001)
	}
	
	@Test
	def Un_Plato_Al_Quitarle_Uno_De_Sus_Dos_Ingredientes_Extras_Su_Precio_Baja_A_100()
	{
		//Setup
		morronAdapter.activado = true
		morronAdapter.distribucionSeleccionada = DistribucionEnPizza.Toda
		salameAdapter.activado = true
		salameAdapter.distribucionSeleccionada = DistribucionEnPizza.Toda
		elPlatoDePrueba.ingredientesExtras.add(morronAdapter)
		elPlatoDePrueba.ingredientesExtras.add(salameAdapter)
		
		//Exercise
		elPlatoDePrueba.ingredientesExtras.remove(morronAdapter)
		elPlatoDePrueba.calcularPrecio
		
		//test
		assertEquals(100.0, elPlatoDePrueba.precio ,0.001)
	}
	
	
	
}