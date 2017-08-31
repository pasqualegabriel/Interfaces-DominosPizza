import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test

class IngredientesTest 
{

	Ingrediente muzzarella
	
	@Before
	def void SetUp()
	{
		muzzarella	= new Ingrediente("Muzzarella" , 20)
	}
	
	@Test
	def Dado_Un_Ingrediente_Recien_Creado_Si_Le_Pido_Su_Nombre_Y_Precio_Los_Da()
	{
		//Setup
		//Excercise
		//Test
		assertEquals("Muzzarella", muzzarella.nombre())
		assertEquals(20, muzzarella.precio())			
	}
	
	@Test
	def Dado_Un_Ingrediente_Si_Se_Cambia_El_Precio_Este_Lo_Actualiza()
	{
		//Setup
		//Excercise
		muzzarella.cambiarPrecio(55)
		//Test
		assertEquals(55, muzzarella.precio())	
	}
	
	@Test
	def Dado_Un_Ingrediente_Si_Se_Cambia_El_Nombre_Este_Lo_Actualiza()
	{
		//Setup
		//Excercise
		muzzarella.cambiarNombre("Muzzarella Especial")
		//Test
		assertEquals("Muzzarella Especial", muzzarella.nombre())		
	}
	
}