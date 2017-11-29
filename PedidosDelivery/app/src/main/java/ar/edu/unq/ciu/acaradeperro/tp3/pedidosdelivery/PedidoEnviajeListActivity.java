package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

/**
 * An activity representing a list of Pedidos En Viaje. This activity
 * has different presentations for handset and tablet-size devices. On
 * handsets, the activity presents a list of items, which when touched,
 * lead to a {@link PedidoEnviajeDetailActivity} representing
 * item details. On tablets, the activity presents the list of items and
 * item details side-by-side using two vertical panes.
 */
public class PedidoEnviajeListActivity extends FragmentActivity implements Callbacks {

    /**
     * Whether or not the activity is in two-pane mode, i.e. running on a tablet
     * device.
     */
    private boolean mTwoPane;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pedidoenviaje_list);
        setAccionesABotones();

         if (findViewById(R.id.pedidoenviaje_detail_container) != null) {
            // The detail container view will be present only in the
            // large-screen layouts (res/values-w900dp).
            // If this view is present, then the
            // activity should be in two-pane mode.
            mTwoPane = true;

             (
                     (PedidoEnViajeListFragment) getSupportFragmentManager()
                             .findFragmentById(R.id.pedidoenviaje_list)
             ).setActivateOnItemClick(true);
        }

    }

    /** Implementacion del callbacks para mostrar el pedido seleccionado.
     * Si es tablet(mTwoPanel=True) carga el fragmento del detalle y lo muestra con el pedido seleccionado.
     * Si es celular(mTwoPanel=False) hace un intento de iniciar la actividad y le pasa la id del pedido a mostrar*/
    @Override
    public void onItemSelected(String unIDPedido) {

        if (mTwoPane) {
            // In two-pane mode, show the detail view in this activity by
            // adding or replacing the detail fragment using a
            // fragment transaction.
            Bundle arguments = new Bundle();
            arguments.putString(PedidoEnviajeDetailFragment.ARG_ITEM_ID, unIDPedido);
            PedidoEnviajeDetailFragment fragment = new PedidoEnviajeDetailFragment();
            fragment.setArguments(arguments);
            getSupportFragmentManager().beginTransaction()
                    .replace(R.id.pedidoenviaje_detail_container, fragment)
                    .commit();

        } else {
            // In single-pane mode, simply start the detail activity
            // for the selected item ID.
            Intent detailIntent = new Intent(this, PedidoEnviajeDetailActivity.class);
            detailIntent.putExtra(PedidoEnviajeDetailFragment.ARG_ITEM_ID, unIDPedido);
            startActivity(detailIntent);
        }
    }

    private void setAccionesABotones()
    {
        final TextView  textoPedido         =(TextView) findViewById(R.id.pedidos_a_ver);
        Button buttonPedidosEnViaje         =(Button) findViewById(R.id.en_viaje);
        Button buttonPedidosListosParaEnviar=(Button) findViewById(R.id.listo_para_enviar);

        buttonPedidosEnViaje.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                /*SE PODRIA MEJORAR HACIENDO QUE LA ACTIVITY GUARDE EL FRAGMENT A LA HORA DE IMPLANTARLO, ASI NO SE CASTEA*/
                ((PedidoEnViajeListFragment) getSupportFragmentManager().findFragmentById(R.id.pedidoenviaje_list))
                                                                        .obtenerPedidosPorEstado("EnViaje");
                textoPedido.setText("Pedidos En Viaje:");
            }
        });

        buttonPedidosListosParaEnviar.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                ((PedidoEnViajeListFragment) getSupportFragmentManager().findFragmentById(R.id.pedidoenviaje_list))
                                                                        .obtenerPedidosPorEstado("ListoParaEnviar");
                textoPedido.setText("Pedidos Listos Para Enviar:");
            }
        });
    }

}