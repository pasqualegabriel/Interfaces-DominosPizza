package DominoPizzaInicio

import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import agregarPizza.IngredienteAdapter
import pizza.Ingrediente
import pizza.Pizza
import pizza.Distribucion
import pizza.DistribucionEnPizza

class IngredienteAdapterTest {
	
	private IngredienteAdapter ingredienteAdapterSUT
	private IngredienteAdapter ingredienteAdapterSUT2
	
	private Ingrediente ingredienteDOC
	private Distribucion distribucionDOC
	private Pizza pizzaDOC
	
	private Ingrediente ingredienteDOC2

	
	@Before
	def void SetUp()
	{	ingredienteDOC = new Ingrediente("pepino",3.00)
		distribucionDOC = new Distribucion
		distribucionDOC.agregarIngrediente(ingredienteDOC,DistribucionEnPizza.Toda)
		pizzaDOC = new Pizza("Muzza",30.00,distribucionDOC)
		
		ingredienteDOC2= new Ingrediente("cerdo", 20.00)
		
		ingredienteAdapterSUT = new IngredienteAdapter(ingredienteDOC, pizzaDOC)
		ingredienteAdapterSUT2 = new IngredienteAdapter(ingredienteDOC2, pizzaDOC)
		
	}
	
	@Test	
	def unIngredienteAdapterSeInstanciaActivadoYConSuDistribucionSeleccionadaPorQueElIngredienteYaEstaEnLaPizza(){
		assertTrue(ingredienteAdapterSUT.getActivado)
		assertNotNull(ingredienteAdapterSUT.distribucionSeleccionada)
	}
	
	@Test	
	def unIngredienteAdapterSeInstanciaDesactivadoYSinDistribucionSeleccionadaPorQueElIngredienteNoEstaEnLaPizza(){
		assertFalse(ingredienteAdapterSUT2.getActivado)
		assertNull(ingredienteAdapterSUT.distribucionSeleccionada)
	}
	
	@Test	
	def unIngredienteAdapterSeAgregaALaPizzaExitosamentePorQueEstaActivadoYConDistribucionSeleccionada(){
		ingredienteAdapterSUT.agregarse
		
		assertTrue(pizzaDOC.distribucion.tieneAlIngrediente(ingredienteAdapterSUT.ingrediente))
	}
	
	@Test	
	def unIngredienteAdapterNoSeAgregaALaPizzaPorQueSeDesactivo(){
		ingredienteAdapterSUT.activado = false
		ingredienteAdapterSUT.agregarse
		
		assertFalse(pizzaDOC.distribucion.tieneAlIngrediente(ingredienteAdapterSUT.ingrediente))	
	}
	@Test	
	def unIngredienteAdapterNoSeAgregaALaPizzaPorQueSuEstaActivadoPeroSinDistribucionSeleccionada(){
		ingredienteAdapterSUT.distribucionSeleccionada= null
		ingredienteAdapterSUT.agregarse
		
		assertFalse(pizzaDOC.distribucion.tieneAlIngrediente(ingredienteAdapterSUT.ingrediente))
	}
}