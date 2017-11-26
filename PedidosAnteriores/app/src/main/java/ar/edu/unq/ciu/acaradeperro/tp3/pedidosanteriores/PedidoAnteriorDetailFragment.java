package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import android.app.Activity;
import android.content.Intent;
import android.support.design.widget.CollapsingToolbarLayout;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.PedidoService;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.ServiceAPIManager;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.dummy.DummyContent;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pedido;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Plato;
import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

/**
 * A fragment representing a single Pedido Anterior detail screen.
 * This fragment is either contained in a {@link PedidoAnteriorListActivity}
 * in two-pane mode (on tablets) or a {@link PedidoAnteriorDetailActivity}
 * on handsets.
 */
public class PedidoAnteriorDetailFragment extends Fragment {
    /**
     * The fragment argument representing the item ID that this fragment
     * represents.
     */
    public static final String ARG_ITEM_ID = "item_id";

    /**
     * The dummy content this fragment is presenting.
     */
    private DummyContent.DummyItem mItem;

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public PedidoAnteriorDetailFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        if (getArguments().containsKey(ARG_ITEM_ID))
        {
            String itemID = getArguments().getString(ARG_ITEM_ID);
            traerPedido(itemID);
        }
        /*
        if (getArguments().containsKey(ARG_ITEM_ID))
        {
            // Load the dummy content specified by the fragment
            // arguments. In a real-world scenario, use a Loader
            // to load content from a content provider.
            mItem = DummyContent.ITEM_MAP.get(getArguments().getString(ARG_ITEM_ID));

            Activity activity = this.getActivity();
            CollapsingToolbarLayout appBarLayout = (CollapsingToolbarLayout) activity.findViewById(R.id.toolbar_layout);
            if (appBarLayout != null)
            {   appBarLayout.setTitle(mItem.content);   }
        }*/
    }

    private void traerPedido(String idPedido)
    {
     /*   if (PedidoService.getInstance().hayPedidos())
        {

        }
        else
        {*/
            ServiceAPIManager servicesPedido = PedidoService.getInstance().createServiceAPIManager();
            servicesPedido.getPedidoAnterior(idPedido, new Callback<Pedido>()
                            {
                                @Override
                                public void success(Pedido pedido, Response response)
                                {   mostrarPedido(pedido);  }

                                @Override
                                public void failure(RetrofitError error)
                                {   Toast.makeText(getContext(),"Hubo un problema, reintente por favor", Toast.LENGTH_LONG).show();  }
                            }
                    );
        //}
    }

    private void mostrarPedido(Pedido unPedidoAnterior)
    {
        ((TextView) this.getView().findViewById(R.id.pedido_titulo)).setText(unPedidoAnterior.titulo());
        ((TextView) this.getView().findViewById(R.id.pedido_estado)).setText(unPedidoAnterior.getEstadoActual());
        ((TextView) this.getView().findViewById(R.id.pedido_direccion)).setText(unPedidoAnterior.direccionDeRetiro());
        ((TextView) this.getView().findViewById(R.id.pedido_aclaracion)).setText(unPedidoAnterior.getAclaracion());
        ((TextView) this.getView().findViewById(R.id.pedido_precio)).setText(unPedidoAnterior.getMonto().toString());
        ((TextView) this.getView().findViewById(R.id.pedido_tiempoDeEspera)).setText(unPedidoAnterior.getTiempoDeEspera().toString());
        this.listarPlatos(unPedidoAnterior.getPlatos());

        //((ListView) this.getView().findViewById(R.id.pedido_platos))

    }

    private void listarPlatos(List<Plato> platosDelPedido) {
        ListView listView = (ListView) this.getView().findViewById(R.id.pedido_platos);
        //List<String> nombres = new ArrayList<>();



        //ArrayAdapter<String> adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, platosDelPedido);
/*
        listView.setAdapter(new ArrayAdapter<Plato>(
                getActivity(),
                android.R.layout.simple_list_item_activated_1,
                android.R.id.text1,
                platosDelPedido
        ));*/
        listView.setAdapter(new PlatoAdapter(getContext(),platosDelPedido));
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.pedidoanterior_detail, container, false);

        // Show the dummy content as text in a TextView.
        /*if (mItem != null) {
            ((TextView) rootView.findViewById(R.id.pedidoanterior_detail)).setText(mItem.details);
        }*/

        return rootView;
    }
}
