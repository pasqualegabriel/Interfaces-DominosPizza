package pedido

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class HolaMundo {
	
	String pepe
	
	new(){
		pepe= "Hola Mundo!"
	}
}