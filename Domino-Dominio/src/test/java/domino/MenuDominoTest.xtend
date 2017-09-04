package domino

import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import domino.MenuDomino
import pizza.Pizza
import pizza.Ingrediente

class MenuDominoTest 
{
	// Estructura
	@Mock Pizza       unaPizzaDeMuzza
	@Mock Ingrediente unSalame
		  MenuDomino  menuPrueba
		  
	// Setup
	@Before
	def void setUp(){
		menuPrueba	= new MenuDomino()
		MockitoAnnotations.initMocks(this)
	}
	
	// Tests
	@Test
	def test00Dado_Un_Menu_Recien_Creado_Este_No_Tiene_Ni_Promociones_Ni_Ingredientes()
	{
		// Assertion
		assertTrue(menuPrueba.ingredientesDisponibles().isEmpty())
		assertTrue(menuPrueba.promocionesDisponibles() .isEmpty())
	}
	
	@Test
	def test01Dado_Un_Menu_Recien_Creado_Si_Le_Agrego_Una_Pizza_En_Promocion_Las_Promociones_Disponibles_Tienen_Una_Promocion_Y_Es_Esa()
	{
		// Exercise
		menuPrueba.agregarPromocion(unaPizzaDeMuzza)
		
		// Assertion
		assertTrue(!menuPrueba.promocionesDisponibles().isEmpty())		
		assertTrue(menuPrueba.promocionesDisponibles().get(0) == unaPizzaDeMuzza)
	}
	
	@Test
	def test02Dado_Un_Menu_Con_Una_Pizza_En_Promocion_Si_La_Quiero_Volver_A_Agregar_No_Lo_Hace()
	{
		// Setup
		menuPrueba.agregarPromocion(unaPizzaDeMuzza)
		
		// Exercise
		menuPrueba.agregarPromocion(unaPizzaDeMuzza)
		
		// Assertion
		assertTrue  (!menuPrueba.promocionesDisponibles().isEmpty())
		assertEquals(1,menuPrueba.promocionesDisponibles().size())
	}
	
	@Test
	def test03Dado_Un_Menu_Con_Una_Pizza_Promocion_Si_Se_Lo_Saca_Ya_No_Quedan_Promos_Disponibles()
	{
		// Setup
		menuPrueba.agregarPromocion(unaPizzaDeMuzza)
		
		// Exercise
		menuPrueba.borrarPromocion(unaPizzaDeMuzza)
		
		// Assertion
		assertTrue(menuPrueba.promocionesDisponibles().isEmpty())
	}
	
	@Test(expected=typeof(RuntimeException))
	def test04Dado_Un_Menu_Sin_Promociones_Disponibles_Si_Se_Trata_De_Sacar_Una_Promocion_Lanza_Error()
	{	
	    // Exercise
		menuPrueba.borrarPromocion(unaPizzaDeMuzza)
		
		// Assertion
		assertTrue(menuPrueba.promocionesDisponibles().isEmpty())
	}
	
	@Test
	def test05Dado_Un_Menu_Recien_Creado_Si_Le_Agrego_Un_Ingrediente_Los_Ingredientes_Disponibles_Tiene_Un_Ingrediente_Y_Es_Ese()
	{
		// Exercise
		menuPrueba.agregarIngrediente(unSalame)
		
		// Assertion
		assertTrue(!menuPrueba.ingredientesDisponibles().isEmpty())
	}
	
	@Test
	def test06Dado_Un_Menu_Con_Un_Ingrediente_Disponible_Si_Lo_Quiero_Volver_A_Agregar_No_Lo_Hace()
	{
		// Setup
		menuPrueba.agregarIngrediente(unSalame)
		
		// Exercise
		menuPrueba.agregarIngrediente(unSalame)
		
		// Assertion
		assertTrue(!menuPrueba.ingredientesDisponibles().isEmpty())
		assertEquals(1,menuPrueba.ingredientesDisponibles().size())
	}
	
	@Test
	def test07Dado_Un_Menu_Con_Un_Ingrediente_Disponible_Si_Se_Lo_Saca_Ya_No_Quedan_Ingredientes_Disponibles()
	{
		// Setup
		menuPrueba.agregarIngrediente(unSalame)
		
		// Exercise
		menuPrueba.borrarIngrediente(unSalame)
		
		// Assertion
		assertTrue(menuPrueba.ingredientesDisponibles().isEmpty())
	}
	
	@Test(expected=typeof(RuntimeException))
	def test08Dado_Un_Menu_Sin_Ingredientes_Disponibles_Si_Se_Saca_Un_Ingrediente_Que_No_Esta_Lanza_Error()
	{		
		// Exercise
		menuPrueba.borrarIngrediente(unSalame)
		
		// Assertion
		assertTrue(menuPrueba.ingredientesDisponibles().isEmpty())
	}
}
				