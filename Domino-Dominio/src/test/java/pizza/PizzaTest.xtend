package pizza

import static org.junit.Assert.*
import static org.mockito.Mockito.*
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import org.mockito.Spy
import pizza.Pizza
import pizza.Distribucion
import pizza.Ingrediente
import pizza.DistribucionEnPizza

class PizzaTest 
{
	// Estructura
		  Pizza			pizzaDePrueba
	@Mock Ingrediente 	queso 
	@Spy  Distribucion	unaDistribucion
	
	// Setup
	@Before
	def void setUp()
	{
		MockitoAnnotations.initMocks(this)
		pizzaDePrueba	= new Pizza("Muzzarella", 75.00, unaDistribucion)
	}
	
	// Tests
	@Test
	def test00Dada_Una_Pizza_Recien_Creada_Si_Se_Le_Pide_Su_Nombre_Su_Precio_Y_Sus_Ingredientes_Los_Da()
	{
		assertEquals("Muzzarella",pizzaDePrueba.nombre)	
		assertEquals(75.00,pizzaDePrueba.precioBase,000001)
		assertEquals(unaDistribucion, pizzaDePrueba.distribucion)
	}
	
	@Test
	def test01Dada_Una_Pizza_Si_Le_Cambio_El_Nombre_Y_Se_Lo_Pido_Devuelve_El_Nuevo_Nombre()
	{
		// Exercise
		pizzaDePrueba.cambiarNombre("Jamon y Anchoas")
		
		// Assertion
		assertEquals("Jamon y Anchoas",pizzaDePrueba.nombre)
	}

	@Test
	def test02Dada_Una_Pizza_Si_Le_Cambio_El_Precio_Y_Se_Lo_Pido_Devuelve_El_Nuevo_Precio()
	{
		// Exercise
		pizzaDePrueba.cambiarPrecio(90.00)
		
		// Assertion
		assertEquals(90.00,pizzaDePrueba.precioBase,0.000001)
	}

	@Test
	def test03Dada_Una_Pizza_Sin_Ingredientes_Si_Le_Agrego_Un_Ingrediente_Nuevo_Este_Esta_Entre_Sus_Ingredientes_Y_Es_El_Unico()
	{
		// Exercise
		pizzaDePrueba.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		// Assertion
		assertTrue(pizzaDePrueba.distribucion.tieneAlIngrediente(queso))
		verify(unaDistribucion, times(1)).agregarIngrediente(queso,DistribucionEnPizza.Toda)
	}
	
	@Test
	def test04Dada_Una_Pizza_Con_Un_Ingrediente_Si_Se_Lo_Quito_La_Pizza_Ya_No_Tiene_Ingredientes()
	{
		// Setup
		doReturn(false).when(unaDistribucion).tieneIngredientes()
		pizzaDePrueba.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		// Exercise
		pizzaDePrueba.quitarIngrediente(queso)
		
		// Assertion
		assertTrue(!pizzaDePrueba.distribucion.tieneIngredientes())
		verify(unaDistribucion, times(1))     .tieneIngredientes()
		verify(unaDistribucion, times(1))     .quitarIngrediente(queso)
		verify(unaDistribucion, times(1))     .agregarIngrediente(queso,DistribucionEnPizza.Toda)
	}
	
	@Test(expected=typeof(RuntimeException))
	def test05Dada_Una_Pizza_Con_Un_Ingrediente_Si_Se_Quiere_Quitar_Un_Ingrediente_Que_No_Hay_Da_Una_Excepcion()
	{
		// Setup
		doReturn(new RuntimeException("No Esta el ingrediente a sacar")).when(unaDistribucion).quitarIngrediente(queso)
		
		// Exercise
		pizzaDePrueba.quitarIngrediente(queso)
		
		// Assertion
		assertTrue(pizzaDePrueba.distribucion.tieneIngredientes())
		verify(unaDistribucion, times(1))    .tieneIngredientes
		verify(unaDistribucion, times(1))    .quitarIngrediente(queso)
	}
	
	@Test
	def test06Dada_Una_Pizza_Con_Un_Ingrediente_Si_Le_Cambio_La_Distribucion_Este_Lo_Registra()
	{
		// Setup
		pizzaDePrueba.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		// Exercise
		pizzaDePrueba.cambiarDistribucionDe(queso,DistribucionEnPizza.Izquierda)
		
		// Assertion
		assertTrue(pizzaDePrueba.distribucion.tieneIngredientes())
		assertEquals("Izquierda", pizzaDePrueba.distribucion.posicionIngrediente(queso).name)
	}
}
		