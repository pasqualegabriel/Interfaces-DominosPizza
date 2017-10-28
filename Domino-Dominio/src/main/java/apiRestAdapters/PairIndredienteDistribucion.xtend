package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PairIndredienteDistribucion {
	String nombre
	String distribucion
	new(){}
	
	new(String aNombre, String aDistribucion){
		nombre			=	aNombre
		distribucion	= aDistribucion
	}
}