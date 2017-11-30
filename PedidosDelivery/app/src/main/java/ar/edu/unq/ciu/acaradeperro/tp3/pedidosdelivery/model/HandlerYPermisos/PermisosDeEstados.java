package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.HandlerYPermisos;

import android.widget.TextView;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.PedidoEnViajeListFragment;


/**
 * Created by some on 30/11/17.
 */

public abstract class PermisosDeEstados {

    public void ejecutar(PedidoEnViajeListFragment unFragmento, TextView aTextView){
        unFragmento.obtenerPedidosPorEstado(this);
        aTextView.setText(this.getText());
    }

    public abstract String getNombre();
    public abstract String getText();
}
