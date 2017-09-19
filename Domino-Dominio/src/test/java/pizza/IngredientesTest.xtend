package pizza

import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import pizza.Ingrediente

class IngredientesTest 
{
	// Estructura
	Ingrediente muzzarella
	
	// Setup
	@Before
	def void setUp()
	{
		muzzarella	= new Ingrediente("Muzzarella" , 20.00)
	}
	
	// Tests
	@Test
	def test01Dado_Un_Ingrediente_Recien_Creado_Si_Le_Pido_Su_Nombre_Y_Precio_Los_Da()
	{
		// Assertion
		assertEquals("Muzzarella", muzzarella.nombre)
		assertEquals(20, muzzarella.precio, 0.00001)			
	}
	
	@Test
	def test02Dado_Un_Ingrediente_Si_Se_Cambia_El_Precio_Este_Lo_Actualiza()
	{
		// Exercise
		muzzarella.cambiarPrecio(55.00)
		
		// Assertion
		assertEquals(55.00, muzzarella.precio, 0.00001)
	}
	
	@Test
	def test03Dado_Un_Ingrediente_Si_Se_Cambia_El_Nombre_Este_Lo_Actualiza()
	{
		// Exercise
		muzzarella.cambiarNombre("Muzzarella Especial")
		
		// Assertion
		assertEquals("Muzzarella Especial", muzzarella.nombre)		
	}
	
}
