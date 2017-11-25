package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;


public class PairIngredienteDistribucionPizza
{
    Ingrediente			ingrediente;
    DistribucionEnPizza distribucion;

    public PairIngredienteDistribucionPizza(Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion) {
        this.ingrediente = unIngrediente;
        this.distribucion = unaDistribucion;
    }
}
