package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery;

import android.app.Activity;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.Service.PedidoService;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.Service.ServiceAPIManager;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.EstadoEnum;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.Pedido;
import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

/**
 * Created by Victor on 27/11/2017.
 */

public class PedidoEnViajeListFragment extends ListFragment
{
    ArrayList<Pedido> pedidosDelivery = new ArrayList<Pedido>();
    EstadoEnum state = EstadoEnum.ListoParaEnviar;
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
    private static Callbacks sDummyCallbacks = new Callbacks()
    {
        @Override
        public void onItemSelected(String unIDPedido) { }
    };

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public PedidoEnViajeListFragment() {}

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onStart()
    {
        super.onStart();
        this.actualizador();
    }

    public void actualizador()
    {
        getListView().clearChoices();
        final TextView textoPedido         = getActivity().findViewById(R.id.pedidos_a_ver);

        if(state.equals(EstadoEnum.ListoParaEnviar))  {
            obtenerPedidosPorEstado(EstadoEnum.ListoParaEnviar);
            textoPedido.setText("Pedidos Listos Para Enviar:");
        }
        else  {
            obtenerPedidosPorEstado(EstadoEnum.EnViaje);
            textoPedido.setText("EnViaje");
        }

    }

    public void agregarPedidos(List<Pedido> pedidos)
    {   setListAdapter(new PedidoAdapter(getActivity(), pedidos));  }

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
        Pedido unPedidoAnterior = (Pedido) listView.getAdapter().getItem(position); //Obtiene la posicion en la lista del pedido seleccionado
        mCallbacks.onItemSelected(String.valueOf(unPedidoAnterior.getId()));        //Se lo pasa al callback
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        if (mActivatedPosition != ListView.INVALID_POSITION) {
            // Serialize and persist the activated item position.
            outState.putInt(STATE_ACTIVATED_POSITION, mActivatedPosition);
        }
    }
    @Override
    public void onDestroyView(){
        super.onDestroyView();
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


    /**Obtiene los pedidos del servidor para poder mostrarlos
     * TIENE QUE TRAER SOLO LOS EN VIAJE O LISTO PARA ENVIAR*/
    public void obtenerPedidosPorEstado(EstadoEnum unEstado)
    {
        //Crea el service para comunicarse con la api.
        ServiceAPIManager servicesPedido = PedidoService.getInstance().createServiceAPIManager();

        state = unEstado;
        //Se comunica con el service y se le pasa un callback para manejar los casos de en donde sea exitosa la request o falle
        servicesPedido.getPedidosPorEstado

                (unEstado.toString(), new Callback<ArrayList<Pedido>>()
                        {
                            @Override
                            public void success(ArrayList<Pedido> pedidos, Response response)
                            {
                                agregarPedidos(pedidos);
                            }

                            @Override
                            public void failure(RetrofitError error)
                            {   Toast.makeText(getContext(),"Hubo un problema, reintente por favor", Toast.LENGTH_LONG).show();  }
                        }
                );
    }



}
