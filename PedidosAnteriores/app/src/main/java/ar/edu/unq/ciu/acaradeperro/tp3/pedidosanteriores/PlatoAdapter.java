package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import android.content.Context;
import android.support.annotation.Nullable;
import android.view.View;
import android.view.ViewGroup;

import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Plato;

/**
 * Created by Victor on 26/11/2017.
 */

public class PlatoAdapter extends AbstractListAdapter<Plato>  {

    public PlatoAdapter(Context context, List<Plato> platosDelPedido) {
        super(context, platosDelPedido);
    }

    /**Devuelve la fila con el contenido a mostrar del pedido*/
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        Plato unPlato = (Plato) getItem(position);

        View row = generateRow(R.layout.plato_row, parent);
        setColumnTextView(row, R.id.plato_pizza, unPlato.nombreDeLaPizza());
        setColumnTextView(row, R.id.plato_tamanio, unPlato.nombreDeTamanio());
        setColumnTextView(row, R.id.plato_extras, unPlato.listaDeIngredientesExtras());

        return row;
    }

}
