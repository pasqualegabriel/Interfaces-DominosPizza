package pizza

import static org.junit.Assert.*
import static org.mockito.Mockito.*
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import pizza.Distribucion
import pizza.Ingrediente
import pizza.DistribucionEnPizza

class DistribucionTest 
{
	// Estructura
		  Distribucion	 unaDistribucion
	@Mock Ingrediente 	 queso
	@Mock Ingrediente 	 jamon
	
	// Setup
	@Before
	def setUp()
	{
		unaDistribucion	= new Distribucion()
		MockitoAnnotations.initMocks(this)
	}
	
	// Tests
	@Test
	def test00Dada_Una_Distribucion_Recien_Creada_Esta_No_tiene_Ingredientes()
	{
		// Assertion	
		assertTrue(unaDistribucion.ingredientes.isEmpty)
	}
	
	@Test
	def test01Dada_Una_Distribucion_Sin_Ingredientes_Si_Se_Le_Agrega_Un_Ingrediente_Ya_No_Esta_Vacia_La_Lista_De_Ingredientes()
	{
		// Exercise
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		// Assertion
		assertTrue  (!unaDistribucion .ingredientes.isEmpty)
		assertEquals(1,unaDistribucion.ingredientes.size)
		assertTrue  (unaDistribucion  .ingredientes.containsKey(queso))
	}
	
	@Test
	def test02Dada_Una_Distribucion_Con_Un_Ingrediente_Si_Se_Lo_Quito_Ya_No_Hay_Ingredientes()
	{
		// Setup
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		// Exercise
		unaDistribucion.quitarIngrediente(queso)
		
		// Assertion
		assertTrue(unaDistribucion.ingredientes.isEmpty())
	}
	
	@Test(expected=typeof(RuntimeException))
	def test03Dada_Una_Distribucion_Con_Un_Ingrediente_Si_Se_Quiere_Quitar_Un_Ingrediente_Que_No_Hay_Da_Una_Excepcion()
	{
		// Exercise
		unaDistribucion.quitarIngrediente(queso)
		
		// Assertion
		assertTrue(unaDistribucion.ingredientes.isEmpty())
	}
	
	@Test
	def test04Dada_Una_Distribucion_Con_Un_Ingrediente_Si_Le_Cambio_La_Posicion_Del_Ingrediente_Este_Lo_Registra()
	{
		// Setup
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		// Exercise
		unaDistribucion.cambiarDistribucionDe(queso,DistribucionEnPizza.Izquierda)
		
		// Assertion
		assertTrue(!unaDistribucion.ingredientes.isEmpty())
		assertEquals("Izquierda", unaDistribucion.ingredientes.get(queso).name)
	}
	
	@Test
	def test05Dada_Una_Distribucion_Sin_Ingredientes_Si_Le_Pido_Que_Calcule_El_Costo_De_Los_Ingredientes_Devuelve_0()
	{
		// Assertion
		assertEquals(0,00,unaDistribucion.costoDeIngredientes())
	}
	
	@Test
	def test06Dada_Una_Distribucion_Con_Dos_Ingredientes_Si_Le_Pido_Que_Calcule_El_Costo_De_Los_Ingredientes_Devuelve_27()
	{
		// Setup
		when(queso.precio).thenReturn(15.00)
		when(jamon.precio).thenReturn(12.00)
		
		// Exercise
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		unaDistribucion.agregarIngrediente(jamon,DistribucionEnPizza.Izquierda)
		
		// Assertion
		assertEquals(27,00,unaDistribucion.costoDeIngredientes())
	}
	
}
		