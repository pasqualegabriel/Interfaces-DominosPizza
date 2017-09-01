import static org.junit.Assert.*
import static org.mockito.Mockito.*
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import java.util.ArrayList
import org.mockito.Spy
import pizza.Distribucion
import pedido.Plato
import pizza.Pizza
import pizza.Grande
import pizza.Ingrediente
import pizza.DistribucionEnPizza

class PlatoTest 
{
	Plato unPlato
	@Spy Distribucion unaDistribucion
	@Mock Pizza unaDeMuzza
	@Mock Pizza unaCustomizada
	@Mock Pizza unaDeJamon
	@Mock Grande tamanioGrande
	@Mock Ingrediente provolone
	@Mock Ingrediente jamon
	
	@Before
	def void SetUp()
	{
		MockitoAnnotations.initMocks(this)
		unPlato	= new Plato(unaDeMuzza,tamanioGrande,unaDistribucion)		
	}

	@Test
	def Dado_Un_Plato_Recien_Creado_Este_Tiene_Una_Pizza_El_Tamaño_De_La_Pizza_Y_Una_Lista_Sin_Ingredientes_Extras()
	{
		//Setup
		when(tamanioGrande.nombre()).thenReturn("Grande")
		//Excersice
		//Test
		assertEquals(unaDeMuzza,unPlato.pizza())
		assertEquals("Grande",unPlato.tamanio().nombre())
		assertTrue(unPlato.ingredientesExtras().tieneIngredientes)
	}
	
	@Test
	def Dado_Un_Plato_Sin_Ingredientes_Extras_Si_Agrego_Un_Ingrediente_La_Lista_Ya_No_Esta_Vacia()
	{
		//Setup
		//Exercise
		unPlato.agregarIngredienteExtra(provolone, DistribucionEnPizza.Toda)
		//Test
		assertTrue(!unPlato.ingredientesExtras().tieneIngredientes())
		assertTrue(unPlato.ingredientesExtras().tieneAlIngrediente(provolone))
	}
	
	@Test(expected=typeof(RuntimeException))
	def Dado_Un_Plato_Con_Un_Ingrediente_Extra_Si_Trato_De_Quitar_Un_Ingrediente_Que_No_Esta_La_Lista_Tira_Error()
	{
		//Setup
		unPlato.agregarIngredienteExtra(provolone, DistribucionEnPizza.Toda)
		//Exercise
		unPlato.quitarIngredienteExtra(jamon)
		//Test
	}
	
	@Test
	def Dado_Un_Plato_Con_Una_Pizza_De_Muzzarella_Si_Se_La_Cambia_Por_Una_Pizza_Customizada_La_Pizza_Del_Plato_Va_A_Ser_Esta()
	{
		//Setup
		when(unaDeJamon.listaDeIngredientes()).thenReturn(new ArrayList<Ingrediente>())
		//Exercise
		unPlato.cambiarPizza(unaCustomizada)
		//Test
		assertEquals(unaCustomizada, unPlato.pizza())
	}
	
	@Test
	def Dado_Un_Plato_Con_Una_Pizza_De_Muzzarella_Y_Jamon_Como_Ingrediente_Extra_Si_Se_Cambia_Por_Una_Pizza_De_Jamon_No_Hay_Ingredientes_Extras()
	{
		//Setup
		var ingredientesInvalidos	=	new ArrayList<Ingrediente>()
		ingredientesInvalidos.add(jamon)
		when(unaDeJamon.listaDeIngredientes()).thenReturn(ingredientesInvalidos)
		
		//Exercise
		unPlato.agregarIngredienteExtra(jamon,DistribucionEnPizza.Toda)
		unPlato.cambiarPizza(unaDeJamon)
		//Test
		assertTrue(unPlato.ingredientesExtras().tieneIngredientes())
	}
	
	@Test
	def Dado_Un_Plato_Con_Una_Pizza_Customizada_Grande_Y_Sin_Ingredientes_Extras_Si_le_Pido_El_Precio_Devuelve_70()
	{
		//Setup
		when(unaCustomizada.precioBase()).thenReturn(70)
		when(tamanioGrande.factorDeTamanio()).thenReturn(1.doubleValue())
		//Exercise
		unPlato.cambiarPizza(unaCustomizada)			
		//Test
		assertEquals(70, unPlato.calcularPrecio())
	}
	
	@Test
	def Dado_Un_Plato_Con_Una_Pizza_De_Muzzarella_Que_Sale_85_De_Tamaño_Familiar_Y_Con_Jamon_Como_Ingrediente_Extra_Que_Vale_15_Si_le_Pido_El_Precio_Devuelve_100()
	{
		//Setup
		when(unaDeMuzza.precioBase()).thenReturn(85)
		when(tamanioGrande.factorDeTamanio()).thenReturn(1.doubleValue())
		when(jamon.precio()).thenReturn(15)
		//Exercise
		unPlato.agregarIngredienteExtra(jamon,DistribucionEnPizza.Izquierda)	
		//Test
		assertEquals(100, unPlato.calcularPrecio())
	}

}