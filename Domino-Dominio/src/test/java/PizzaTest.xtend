import static org.junit.Assert.*
import static org.mockito.Mockito.*
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import org.mockito.Spy


class PizzaTest 
{
	Pizza pizzaDePrueba
	@Mock Ingrediente queso 
	@Spy Distribucion unaDistribucion
	
	@Before
	def void SetUp()
	{
		MockitoAnnotations.initMocks(this)
		pizzaDePrueba	= new Pizza("Muzzarella", 75, unaDistribucion)
	}
	
	@Test
	def Dada_Una_Pizza_Recien_Creada_Si_Se_Le_Pide_Su_Nombre_Su_Precio_Y_Sus_Ingredientes_Los_Da()
	{
		//Setup
		//Exercise
		//Test		
		assertEquals("Muzzarella",pizzaDePrueba.nombre())	
		assertEquals(75,pizzaDePrueba.precioBase())
		assertEquals(unaDistribucion, pizzaDePrueba.distribucion())
	}
	
	@Test
	def Dada_Una_Pizza_Si_Le_Cambio_El_Nombre_Y_Se_Lo_Pido_Devuelve_El_Nuevo_Nombre()
	{
		//Setup
		//Exercise
		pizzaDePrueba.cambiarNombre("Jamon y Anchoas")
		
		//Test
		assertEquals("Jamon y Anchoas",pizzaDePrueba.nombre())
	}

	@Test
	def Dada_Una_Pizza_Si_Le_Cambio_El_Precio_Y_Se_Lo_Pido_Devuelve_El_Nuevo_Precio()
	{
		//Setup
		//Exercise
		pizzaDePrueba.cambiarPrecio(90)
		
		//Test
		assertEquals(90,pizzaDePrueba.precioBase())
	}

	@Test
	def Dada_Una_Pizza_Sin_Ingredientes_Si_Le_Agrego_Un_Ingrediente_Nuevo_Este_Esta_Entre_Sus_Ingredientes_Y_Es_El_Unico()
	{
		//Setup
		//Exercise
		pizzaDePrueba.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		//Test
		assertTrue(pizzaDePrueba.distribucion().tieneAlIngrediente(queso))
		verify(unaDistribucion, times(1)).agregarIngrediente(queso,DistribucionEnPizza.Toda)
	}
	
	@Test
	def Dada_Una_Pizza_Con_Un_Ingrediente_Si_Se_Lo_Quito_La_Pizza_Ya_No_Tiene_Ingredientes()
	{
		//Setup
		doReturn(false).when(unaDistribucion).tieneIngredientes()
		pizzaDePrueba.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		//Exercise
		pizzaDePrueba.quitarIngrediente(queso)
		
		//Test
		assertTrue(!pizzaDePrueba.distribucion().tieneIngredientes())
		verify(unaDistribucion, times(1)).tieneIngredientes()
		verify(unaDistribucion, times(1)).quitarIngrediente(queso)
		verify(unaDistribucion, times(1)).agregarIngrediente(queso,DistribucionEnPizza.Toda)
	}
	
	@Test(expected=typeof(RuntimeException))
	def Dada_Una_Pizza_Con_Un_Ingrediente_Si_Se_Quiere_Quitar_Un_Ingrediente_Que_No_Hay_Da_Una_Excepcion()
	{
		//Setup
		doReturn(new RuntimeException("No Esta el ingrediente a sacar")).when(unaDistribucion).quitarIngrediente(queso)
		
		//Exercise
		pizzaDePrueba.quitarIngrediente(queso)
		
		//Test
		assertTrue(pizzaDePrueba.distribucion().tieneIngredientes())
		verify(unaDistribucion, times(1)).tieneIngredientes
		verify(unaDistribucion, times(1)).quitarIngrediente(queso)
	}
	
	@Test
	def Dada_Una_Pizza_Con_Un_Ingrediente_Si_Le_Cambio_La_Distribucion_Este_Lo_Registra()
	{
		//Setup
		pizzaDePrueba.agregarIngrediente(queso,DistribucionEnPizza.Toda)
		
		//Exercise
		pizzaDePrueba.cambiarDistribucionDe(queso,DistribucionEnPizza.Izquierda)
		
		//Test
		assertTrue(!pizzaDePrueba.distribucion().tieneIngredientes())
		assertEquals("Izquierda", pizzaDePrueba.distribucion().posicionIngrediente(queso).name)
	}
}