package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.ServiceAPIManager;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.UsuarioService;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Usuario;
import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

/**
 * An activity representing a list of Pedidos Anteriores. This activity
 * has different presentations for handset and tablet-size devices. On
 * handsets, the activity presents a list of items, which when touched,
 * lead to a {@link PedidoAnteriorDetailActivity} representing
 * item details. On tablets, the activity presents the list of items and
 * item details side-by-side using two vertical panes.
 */
public class PedidoAnteriorListActivity extends FragmentActivity implements Callbacks
{
    /**
     * Whether or not the activity is in two-pane mode, i.e. running on a tablet
     * device.
     */
    private boolean mTwoPane;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pedidoanterior_list);
        //addListenerOnButton();
        setActionGuardarCambios();
        traerUsuario("g");

        if (findViewById(R.id.pedidoanterior_detail_container) != null) {
            // The detail container view will be present only in the
            // large-screen layouts (res/values-w900dp).
            // If this view is present, then the
            // activity should be in two-pane mode.
            mTwoPane = true;

            (
                (PedidoAnteriorListFragment) getSupportFragmentManager()
                    .findFragmentById(R.id.pedidoanterior_list)
            )
            .setActivateOnItemClick(true);
        }



    }
/*
    public void addListenerOnButton() {

        button = (Button) findViewById(R.id.EditarDatos);

        button.setOnClickListener(new View.OnClickListener() {



            @Override
            public void onClick(View arg0) {
                if (mTwoPane) {
                    // In two-pane mode, show the detail view in this activity by
                    // adding or replacing the detail fragment using a
                    // fragment transaction.
                    Bundle arguments = new Bundle();
                    arguments.putString(DatosDeUsuarioFragment.ARG_ITEM_ID, "g");         //Le asigna la id del pedido para usarlo luego
                    DatosDeUsuarioFragment fragment = new DatosDeUsuarioFragment();         //Crea El Fragmento del detalle Del Pedido
                    fragment.setArguments(arguments);                                           //Setea la variable arguments al fragment
                    getSupportFragmentManager().beginTransaction()                              //Le dice al manager que comienze la transaccion
                            .replace(R.id.datos_de_usuario, fragment)                           //con el nuevo fragmento y le pasa el fragment
                            .commit();                                                          //lo "Comitea" para que se muestre

                } else {
                    // In single-pane mode, simply start the detail activity
                    // for the selected item ID.
                    Intent detailIntent = new Intent(getSelf(), DatosDeUsuarioActivity.class);
                    detailIntent.putExtra(DatosDeUsuarioFragment.ARG_ITEM_ID, "g");
                    startActivity(detailIntent);
                }

            }

        });

    }
*/
    private PedidoAnteriorListActivity getSelf(){
        return this;
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
            arguments.putString(PedidoAnteriorDetailFragment.ARG_ITEM_ID, unIDPedido);  //Le asigna la id del pedido para usarlo luego
            PedidoAnteriorDetailFragment fragment = new PedidoAnteriorDetailFragment(); //Crea El Fragmento del detalle Del Pedido
            fragment.setArguments(arguments);                                           //Setea la variable arguments al fragment
            getSupportFragmentManager().beginTransaction()                              //Le dice al manager que comienze la transaccion
                    .replace(R.id.pedidoanterior_detail_container, fragment)            //con el nuevo fragmento y le pasa el fragment
                    .commit();                                                          //lo "Comitea" para que se muestre

        } else {
            // In single-pane mode, simply start the detail activity
            // for the selected item ID.
            Intent detailIntent = new Intent(this, PedidoAnteriorDetailActivity.class);
            detailIntent.putExtra(PedidoAnteriorDetailFragment.ARG_ITEM_ID, unIDPedido);
            startActivity(detailIntent);
        }
    }

    /*Edicion de los datos del Usuario*/
    private void traerUsuario(String idUsuario)
    {
        ServiceAPIManager servicesUsuario = UsuarioService.getInstance().createServiceAPIManager();
        servicesUsuario.getUsuario(idUsuario, new Callback<Usuario>()
                {
                    @Override
                    public void success(Usuario usuario, Response response)
                    {   mostrarUsuario(usuario);  }

                    @Override
                    public void failure(RetrofitError error)
                    {   Toast.makeText(getApplicationContext(),"Hubo un problema, reintente por favor", Toast.LENGTH_LONG).show();  }
                }
        );
    }

    private void mostrarUsuario(Usuario unUsuario)
    {
        ((EditText) findViewById(R.id.editNombreDeUsuario)).setText(unUsuario.getNombre(), TextView.BufferType.EDITABLE);
        ((EditText) findViewById(R.id.editDireccion)).setText(unUsuario.getDireccion(), TextView.BufferType.EDITABLE);
        ((EditText) findViewById(R.id.editMail)).setText(unUsuario.getMail(),TextView.BufferType.EDITABLE);
    }

    private void setActionGuardarCambios()
    {
        Button buttonGuardarCambios =(Button) findViewById(R.id.guardarCambiosButton);
        buttonGuardarCambios.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {

                String nombreAGuardar = ((EditText) findViewById(R.id.editNombreDeUsuario)).getText().toString();
                String direccionAGuardar = ((EditText) findViewById(R.id.editDireccion)).getText().toString();
                String emailAGuardar = ((EditText) findViewById(R.id.editMail)).getText().toString();

        /*Falta Hacer Que Le Pegue a la API*/
            }
        });
    }

    public void onClickGuardarCambios(View view)
    {
    }
}
