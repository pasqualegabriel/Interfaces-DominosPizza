package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import java.util.List;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.Pedido;


public class PedidoAdapter extends AbstractListAdapter<Pedido> {

    public PedidoAdapter(Context context, List<Pedido> pedidosEnviaje) {
        super(context, pedidosEnviaje);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        Pedido unPedido = (Pedido) getItem(position);

        View row = generateRow(R.layout.pedido_row, parent);
        setColumnTextView(row, R.id.titulo, unPedido.titulo());
        setColumnTextView(row, R.id.precio, unPedido.getMonto().toString());
        return row;
    }

}
