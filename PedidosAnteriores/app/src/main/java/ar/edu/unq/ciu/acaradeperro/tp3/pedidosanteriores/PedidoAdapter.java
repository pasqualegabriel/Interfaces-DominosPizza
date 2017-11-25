package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pedido;

/**
 * Created por some noob en android on 25/11/17.
 */

public class PedidoAdapter extends AbstractListAdapter<Pedido> {

    public PedidoAdapter(Context context, List<Pedido> pedidosAnteriores) {
        super(context, pedidosAnteriores);
    }

    /**Devuelve la fila con el contenido a mostrar del pedido*/
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        Pedido unPedido = ( Pedido) getItem(position);

        View row = generateRow(R.layout.pedido_row, parent);
        setColumnTextView(row, R.id.titulo, unPedido.titulo());
        setColumnTextView(row, R.id.precio, unPedido.getMonto().toString());
        return row;
    }

}
