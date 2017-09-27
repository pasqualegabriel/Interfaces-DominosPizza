package testAppModels

import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import pizza.Ingrediente
import pizza.Pizza
import pizza.Distribucion
import pizza.DistribucionEnPizza
import edicionDePromocion.IngredienteAdapter

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
	def test00unIngredienteAdapterSeInstanciaActivadoYConSuDistribucionSeleccionadaPorQueElIngredienteYaEstaEnLaPizza(){
		assertTrue(ingredienteAdapterSUT.getActivado)
		assertNotNull(ingredienteAdapterSUT.distribucionSeleccionada)
	}
	
	@Test	
	def test01unIngredienteAdapterSeInstanciaDesactivadoYSinDistribucionSeleccionadaPorQueElIngredienteNoEstaEnLaPizza(){
		assertFalse(ingredienteAdapterSUT2.getActivado)
		assertNull(ingredienteAdapterSUT2.distribucionSeleccionada)
	}
	
	@Test	
	def test02unIngredienteAdapterSeAgregaALaPizzaExitosamentePorQueEstaActivadoYConDistribucionSeleccionada(){
		pizzaDOC.quitarIngrediente(ingredienteAdapterSUT.ingrediente)
		ingredienteAdapterSUT.agregarse
		
		assertTrue(pizzaDOC.distribucion.tieneAlIngrediente(ingredienteAdapterSUT.ingrediente))
	}
	
	@Test	
	def test03unIngredienteAdapterNoSeAgregaALaPizzaPorQueSeDesactivo(){
		pizzaDOC.quitarIngrediente(ingredienteAdapterSUT.ingrediente)
		ingredienteAdapterSUT.activado = false
		ingredienteAdapterSUT.agregarse
		
		assertFalse(pizzaDOC.distribucion.tieneAlIngrediente(ingredienteAdapterSUT.ingrediente))	
	}
	@Test	
	def test04unIngredienteAdapterNoSeAgregaALaPizzaPorQueEstaActivadoPeroSinDistribucionSeleccionada(){
		pizzaDOC.quitarIngrediente(ingredienteAdapterSUT.ingrediente)
		ingredienteAdapterSUT.distribucionSeleccionada= null
		ingredienteAdapterSUT.agregarse
		
		assertFalse(pizzaDOC.distribucion.tieneAlIngrediente(ingredienteAdapterSUT.ingrediente))
	}
}
		