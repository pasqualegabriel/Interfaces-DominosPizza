package pedido

import org.uqbar.arena.bindings.ValueTransformer

class PrecioTransformer implements ValueTransformer<Double, String>{
	
	override getModelType() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getViewType() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override modelToView(Double valueFromModel) {
		if (valueFromModel == null) {
			return null;
		}
		return '''$ «valueFromModel»'''	
	}
	
	override viewToModel(String valueFromView) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}