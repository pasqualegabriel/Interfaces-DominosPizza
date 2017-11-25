package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Controller.ListadoDePedidos;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.PedidoService;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.ServiceAPIManager;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.HolaMundo;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pedido;
import retrofit.Callback;
import retrofit.RestAdapter;
import retrofit.RetrofitError;
import retrofit.client.Response;

import android.support.v4.app.ListFragment;
import android.widget.Toast;

/**
 * Created by Victor on 23/11/2017.
 */

public class PedidoAnteriorListFragment extends ListFragment{

    //La lista de los Pedidos Anteriores a Mostrar
    List<Pedido> pedidosAnteriores;
    HolaMundo a;
    /**
     * The serialization (saved instance state) Bundle key representing the
     * activated item position. Only used on tablets.
     */
    private static final String STATE_ACTIVATED_POSITION = "activated_position";

    /**
     * The fragment's current callback object, which is notified of list item
     * clicks.
     */
    private Callbacks mCallbacks = sDummyCallbacks;

    /**
     * The current activated item position. Only used on tablets.
     */
    private int mActivatedPosition = ListView.INVALID_POSITION;

    /**
     * A dummy implementation of the {@link Callbacks} interface that does
     * nothing. Used only when this fragment is not attached to an activity.
     */
    private static Callbacks sDummyCallbacks = new Callbacks() {
        @Override
        public void onItemSelected(String unIDPedido) {

        }
    };

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public PedidoAnteriorListFragment()
    {/*Sin Implementacion, constructor vacio necesario para el Fragment Manager*/}

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //Se asigna los pedidos anteriores
        //pedidosAnteriores = ListadoDePedidos.getInstance().todosLosPedidosAnteriores();
        this.obtenerPedidosAnteriores();

        setListAdapter(new ArrayAdapter<>(
                getActivity(),
                android.R.layout.simple_list_item_activated_1,
                android.R.id.text1,
                pedidosAnteriores));
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        // Restore the previously serialized activated item position.
        if (savedInstanceState != null
                && savedInstanceState.containsKey(STATE_ACTIVATED_POSITION)) {
            setActivatedPosition(savedInstanceState.getInt(STATE_ACTIVATED_POSITION));
        }
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);

        // Activities containing this fragment must implement its callbacks.
        if (!(activity instanceof Callbacks)) {
            throw new IllegalStateException("Activity must implement fragment's callbacks.");
        }

        mCallbacks = (Callbacks) activity;
    }

    @Override
    public void onDetach() {
        super.onDetach();

        // Reset the active callbacks interface to the dummy implementation.
        mCallbacks = sDummyCallbacks;
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id) {
        super.onListItemClick(listView, view, position, id);

        // Notify the active callbacks interface (the activity, if the
        // fragment is attached to one) that an item has been selected.
        Pedido unPedidoAnterior = (Pedido) listView.getAdapter().getItem(position);
        mCallbacks.onItemSelected(String.valueOf(unPedidoAnterior.getId()));
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        if (mActivatedPosition != ListView.INVALID_POSITION) {
            // Serialize and persist the activated item position.
            outState.putInt(STATE_ACTIVATED_POSITION, mActivatedPosition);
        }
    }

    /**
     * Turns on activate-on-click mode. When this mode is on, list items will be
     * given the 'activated' state when touched.
     */
    public void setActivateOnItemClick(boolean activateOnItemClick) {
        // When setting CHOICE_MODE_SINGLE, ListView will automatically
        // give items the 'activated' state when touched.
        getListView().setChoiceMode(activateOnItemClick
                ? ListView.CHOICE_MODE_SINGLE
                : ListView.CHOICE_MODE_NONE);
    }

    private void setActivatedPosition(int position) {
        if (position == ListView.INVALID_POSITION) {
            getListView().setItemChecked(mActivatedPosition, false);
        } else {
            getListView().setItemChecked(position, true);
        }

        mActivatedPosition = position;
    }


    private void obtenerPedidosAnteriores() {
       ServiceAPIManager servicesPedido = PedidoService.getInstance().createServiceAPIManager();

        servicesPedido.getPedidosAnteriores("g", new Callback<List<Pedido>>() {
            @Override
            public void success(List<Pedido> pedidos, Response response)
            {
                agregarPedidos(pedidos);
            }

            @Override
            public void failure(RetrofitError error) {
                //Toast.makeText(PedidoAnteriorListFragment.this, "El participante no se pudo cargar, intente nuevamente mas tarde.", Toast.LENGTH_SHORT).show();
                Log.e("", error.getMessage());
                error.printStackTrace();
                throw error;
            }
        });
    }

    private void agregarPedidos(List<Pedido> pedidos) {
        setListAdapter(new PedidoAdapter(getActivity(), pedidos));
    }
}