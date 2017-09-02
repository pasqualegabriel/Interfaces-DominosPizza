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
	Distribucion unaDistribucion
	@Mock Ingrediente queso
	@Mock Ingrediente jamon
	
	@Before
	def SetUp()
	{
		unaDistribucion	= new Distribucion()
		MockitoAnnotations.initMocks(this)
	}
	
	@Test
	def Dada_Una_Distribucion_Recien_Creada_Esta_No_tiene_Ingredientes()
	{
		//Setup
		//Exercise
		//Test		
		assertTrue(unaDistribucion.ingredientes.isEmpty())
	}
	
	@Test
	def Dada_Una_Distribucion_Sin_Ingredientes_Si_Se_Le_Agrega_Un_Ingrediente_Ya_No_Esta_Vacia_La_Lista_De_Ingredientes()
	{
		//Setup
		//Exercise
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		//Test
		assertTrue(!unaDistribucion.ingredientes.isEmpty())
		assertEquals(1,unaDistribucion.ingredientes.size())
		assertTrue(unaDistribucion.ingredientes.containsKey(queso))
	}
	
	@Test
	def Dada_Una_Distribucion_Con_Un_Ingrediente_Si_Se_Lo_Quito_Ya_No_Hay_Ingredientes()
	{
		//Setup
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		//Exercise
		unaDistribucion.quitarIngrediente(queso)
		
		//Test
		assertTrue(unaDistribucion.ingredientes.isEmpty())
	}
	
	@Test(expected=typeof(RuntimeException))
	def Dada_Una_Distribucion_Con_Un_Ingrediente_Si_Se_Quiere_Quitar_Un_Ingrediente_Que_No_Hay_Da_Una_Excepcion()
	{
		//Setup
		//Exercise
		unaDistribucion.quitarIngrediente(queso)
		
		//Test
		assertTrue(unaDistribucion.ingredientes.isEmpty())
	}
	
	@Test
	def Dada_Una_Distribucion_Con_Un_Ingrediente_Si_Le_Cambio_La_Posicion_Del_Ingrediente_Este_Lo_Registra()
	{
		//Setup
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		//Exercise
		unaDistribucion.cambiarDistribucionDe(queso,DistribucionEnPizza.Izquierda)
		
		//Test
		assertTrue(!unaDistribucion.ingredientes.isEmpty())
		assertEquals("Izquierda", unaDistribucion.ingredientes.get(queso).name)
	}
	
	@Test
	def Dada_Una_Distribucion_Sin_Ingredientes_Si_Le_Pido_Que_Calcule_El_Costo_De_Los_Ingredientes_Devuelve_0()
	{
		//Setup
		//Excersice
		//Test
		assertEquals(0,unaDistribucion.costoDeIngredientes())
	}
	
	@Test
	def Dada_Una_Distribucion_Con_Dos_Ingredientes_Si_Le_Pido_Que_Calcule_El_Costo_De_Los_Ingredientes_Devuelve_27()
	{
		//Setup
		when(queso.precio).thenReturn(15)
		when(jamon.precio).thenReturn(12)
		//Excersice
		unaDistribucion.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		unaDistribucion.agregarIngrediente(jamon,DistribucionEnPizza.Izquierda)
		
		//Test
		assertEquals(27,unaDistribucion.costoDeIngredientes())
	}
	
}