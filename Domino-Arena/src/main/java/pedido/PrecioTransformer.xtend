package pedido

import org.uqbar.arena.bindings.ValueTransformer

class PrecioTransformer implements ValueTransformer<Double, String>
{
	override getModelType() 
	{	}
	
	override getViewType() 
	{	}
	
	override modelToView(Double valueFromModel) 
	{	return '''$ «valueFromModel»'''	}
	
	override viewToModel(String valueFromView) 
	{	}
}