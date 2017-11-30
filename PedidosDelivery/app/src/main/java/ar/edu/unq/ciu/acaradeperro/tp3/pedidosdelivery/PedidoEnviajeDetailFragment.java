package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import java.util.List;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.Service.PedidoService;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.Service.ServiceAPIManager;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.dummy.DummyContent;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.Pedido;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.Plato;
import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

/**
 * A fragment representing a single Pedido Enviaje detail screen.
 * This fragment is either contained in a {@link PedidoEnviajeListActivity}
 * in two-pane mode (on tablets) or a {@link PedidoEnviajeDetailActivity}
 * on handsets.
 */
public class PedidoEnviajeDetailFragment extends Fragment {
    /**
     * The fragment argument representing the item ID that this fragment
     * represents.
     */
    public static final String ARG_ITEM_ID = "item_id";
    Pedido pedidoSeleccionado;

    /**
     * The dummy content this fragment is presenting.
     */
    private DummyContent.DummyItem mItem;

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public PedidoEnviajeDetailFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        if (getArguments().containsKey(ARG_ITEM_ID))
        {
            String itemID = getArguments().getString(ARG_ITEM_ID);
            traerPedido(itemID);
        }
    }

    private void traerPedido(String idPedido)
    {
        ServiceAPIManager servicesPedido = PedidoService.getInstance().createServiceAPIManager();
        servicesPedido.getPedidoEnViaje(idPedido, new Callback<Pedido>()
                {
                    @Override
                    public void success(Pedido pedido, Response response)
                    {   mostrarPedido(pedido);
                        setActionBotonesDeEstado();}

                    @Override
                    public void failure(RetrofitError error)
                    {   Toast.makeText(getContext(),"Hubo un problema, reintente por favor", Toast.LENGTH_LONG).show();  }
                }
        );
    }

    private void mostrarPedido(Pedido unPedidoAnterior)
    {
        pedidoSeleccionado = unPedidoAnterior;
        ((TextView) this.getView().findViewById(R.id.pedido_titulo)).setText(unPedidoAnterior.titulo());
        ((TextView) this.getView().findViewById(R.id.pedido_estado)).setText(unPedidoAnterior.getEstadoActual());
        ((TextView) this.getView().findViewById(R.id.pedido_usuario)).setText(unPedidoAnterior.getMiembro());
        ((TextView) this.getView().findViewById(R.id.pedido_direccion)).setText(unPedidoAnterior.direccionDeRetiro());
        ((TextView) this.getView().findViewById(R.id.pedido_aclaracion)).setText(unPedidoAnterior.getAclaracion());
        ((TextView) this.getView().findViewById(R.id.pedido_precio)).setText(unPedidoAnterior.getMonto().toString());
        ((TextView) this.getView().findViewById(R.id.pedido_tiempoDeEspera)).setText(unPedidoAnterior.getTiempoDeEspera().toString());
        this.listarPlatos(unPedidoAnterior.getPlatos());
    }

    private void listarPlatos(List<Plato> platosDelPedido) {
        ListView listView = (ListView) this.getView().findViewById(R.id.pedido_platos);
        listView.setAdapter(new PlatoAdapter(getContext(),platosDelPedido));
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.pedidoenviaje_detail, container, false);

        return rootView;
    }

    private void cambiarEstadoDePedido(Estado nuevoEstado) {
        //Crea el service para comunicarse con la api.
        ServiceAPIManager servicesPedido = PedidoService.getInstance().createServiceAPIManager();

        //Se comunica con el service y se le pasa un callback para manejar los casos de en donde sea exitosa la request o falle
        servicesPedido.cambiarEstadoPedido
                (this.pedidoSeleccionado.getId().toString(), nuevoEstado, new Callback<String>()
                        {
                            @Override
                            public void success(String respuesta, Response response)
                            {
                                getActivity().onBackPressed();
                                Toast.makeText(getContext(),"Cambios guardado", Toast.LENGTH_LONG).show();
                            }

                            @Override
                            public void failure(RetrofitError error)
                            {   Toast.makeText(getContext(),"Hubo un problema, reintente por favor", Toast.LENGTH_LONG).show();  }
                        }
                );
    }

    private void setActionBotonesDeEstado()
    {
        this.setButtonAction("Cancelar",R.id.boton_cancelar, new Estado("Cancelado"));

        if(pedidoSeleccionado.getEstadoActual().equalsIgnoreCase("Listo para enviar"))
        { this.setButtonAction("En Viaje",R.id.boton_cambio, new Estado("En Viaje")); }
        if(pedidoSeleccionado.getEstadoActual().equalsIgnoreCase("En Viaje"))
        { this.setButtonAction("Entregar",R.id.boton_cambio, new Estado("Entregado")); }

    }

    private void setButtonAction(String nombreDelBoton, int idDelBoton, final Estado elEstado) {
        Button buttonAction =(Button) getActivity().findViewById(idDelBoton);
        buttonAction.setText(nombreDelBoton);

        buttonAction.setOnClickListener(new OnClickListener() {
            public void onClick(View v)
            {
                cambiarEstadoDePedido(elEstado);
                pedidoSeleccionado.setEstadoActual(elEstado.nombre);
                ((TextView) getView().findViewById(R.id.pedido_estado)).setText(elEstado.nombre);

            }
        });
    }

}
