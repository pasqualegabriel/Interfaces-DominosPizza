package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Toast;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.ServiceAPIManager;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service.UsuarioService;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Usuario;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.dummy.DummyContent;

import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

/**
 * Created by some on 26/11/17.
 */

public class DatosDeUsuarioFragment extends Fragment {
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
    public DatosDeUsuarioFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        if (getArguments().containsKey(ARG_ITEM_ID))
        {
            String itemID = getArguments().getString(ARG_ITEM_ID);
            traerUsuario(itemID);
        }
    }

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
                    {   Toast.makeText(getContext(),"Hubo un problema, reintente por favor", Toast.LENGTH_LONG).show();  }
                }
        );
    }

    private void mostrarUsuario(Usuario unUsuario)
    {
        // final Usuario usuarioAEditar = unUsuario;

        //final EditText editName = (EditText) this.getView().findViewById(R.id.editNombreDeUsuario);

       // editName.addTextChangedListener(new ObservadorDeTexto(unUsuario,editName));

        //((EditText) this.getView().findViewById(R.id.editNombreDeUsuario)).setText("Pepita",TextView.BufferType.EDITABLE);
        //((EditText) this.getView().findViewById(R.id.editDireccion)).setText("LaLoca",TextView.BufferType.EDITABLE);
        //((EditText) this.getView().findViewById(R.id.editMail)).setText("a@marolio.com",TextView.BufferType.EDITABLE);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.datos_de_usuario_vista, container, false);

        // Show the dummy content as text in a TextView.
        /*if (mItem != null) {
            ((TextView) rootView.findViewById(R.id.pedidoanterior_detail)).setText(mItem.details);
        }*/

        return rootView;
    }

    private class ObservadorDeTexto implements TextWatcher {

        Usuario unUser;
        EditText unEditText;

        public ObservadorDeTexto(Usuario user, EditText editText) {
            unUser= user;
            unEditText=  editText;
        }

        @Override
        public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            unEditText.setText(unUser.getNombre());
        }

        @Override
        public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

        }

        @Override
        public void afterTextChanged(Editable editable) {

        }
    }
}
