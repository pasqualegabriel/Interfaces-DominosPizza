package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;


import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;
import java.util.List;

/**Genera la lista a mostrar*/
public abstract class AbstractListAdapter<T> extends BaseAdapter {
    private Context context;
    private List<T> objects;

    public AbstractListAdapter() {
    }

    public AbstractListAdapter(Context pContext, List<T> severalObjects) {
        context = pContext;
        objects = severalObjects;
    }

    @Override
    public int getCount() {
        return objects.size();
    }

    @Override
    public Object getItem(int position) {
        return objects.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    /** Genera la fila para poner la vista del pedido*/
    public View generateRow(int rowLayoutId, ViewGroup parent) {
        LayoutInflater inflater = LayoutInflater.from(context);
        return inflater.inflate(rowLayoutId, parent, false);
    }

    /**Setea el contenido a mostrar del pedido en la fila pasada por parametro*/
    public void setColumnTextView(View row, int widgetId, String value)
    {
        TextView widget = (TextView) row.findViewById(widgetId); //Casteo redundante traido del ejemplo(Ejemplo libro Rest), quitar!
        widget.setText(value);
    }
}