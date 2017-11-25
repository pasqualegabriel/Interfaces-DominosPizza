package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Controller;


import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Chica;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Distribucion;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.FormaDeRetiro;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Local;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pedido;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pizza;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Plato;

/**
 * Created by Victor on 18/11/2017.
 */

public class ListadoDePedidos
{
    private static final ListadoDePedidos instance  = new ListadoDePedidos();
    private List<Pedido> pedidosAnteriores          = new ArrayList<>();

    public ListadoDePedidos()
    {
        Pedido pedido1                  = new Pedido();
        FormaDeRetiro pedido1Local     = new Local();
        List<Plato> listaDePlatosPedido1= new ArrayList<>();
        Distribucion distirbucionMuzza  = new Distribucion();
        Pizza unaMuzza                  = new Pizza("Muzzarela", 85.0, distirbucionMuzza );
        Plato unaPromoMuzza             = new Plato(unaMuzza, new Chica(), new Distribucion());

        listaDePlatosPedido1.add(unaPromoMuzza);
        pedido1.setPlatos(listaDePlatosPedido1);
        pedido1.setId(1);
        pedido1.setAclaracion("");
        pedido1.setEstadoActual("En Viaje");
        pedido1.setFecha("12/08/2017");
        pedido1.setFormaDeRetiro(pedido1Local);
        pedido1.setMiembro("Victor");
        pedido1.setMonto(150.0);
        pedido1.setTiempoDeEspera(0);

        this.agregarPedido(pedido1);
    }

    private void agregarPedido(Pedido unPedido)
    {   this.pedidosAnteriores.add(unPedido);   }

    public static ListadoDePedidos getInstance()
    {   return instance;    }

    public List<Pedido> todosLosPedidosAnteriores()
    {   return this.pedidosAnteriores;  }

}
