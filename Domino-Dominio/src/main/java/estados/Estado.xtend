package estados
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Estado {
	public String nombre
	
	new(){
		super()
	}
}