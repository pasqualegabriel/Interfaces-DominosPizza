package apiRestAdapters

import pizza.Distribucion
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DistribudorAdapterApi {
		List<PairIndredienteDistribucion> ingredientes= newArrayList;
		
		new(){}
		new(Distribucion distribucion){
			distribucion.ingredientes.forEach[n| ingredientes.add(new PairIndredienteDistribucion(n.ingrediente,n.distribucion.toString))]
		}
		
		def convertir(){
			val list = newArrayList
			ingredientes.forEach[list.add(it.convertir)]
			return new Distribucion(list)
		}

		
}