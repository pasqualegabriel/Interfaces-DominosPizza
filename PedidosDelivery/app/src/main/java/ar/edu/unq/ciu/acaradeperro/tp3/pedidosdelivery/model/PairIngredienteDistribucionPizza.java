package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model;


public class PairIngredienteDistribucionPizza
{
    Ingrediente			ingrediente;
    DistribucionEnPizza distribucion;

    public PairIngredienteDistribucionPizza(Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion) {
        this.ingrediente = unIngrediente;
        this.distribucion = unaDistribucion;
    }

    public String nombreIngrediente() {
        return this.getIngrediente().nombre();
    }

    private Ingrediente getIngrediente()
    {   return this.ingrediente;    }
}
