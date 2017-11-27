package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;

/**
 * Created by some on 26/11/17.
 */

public class DatosDeUsuarioActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.datos_de_usuario);

        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true);
        }

        // savedInstanceState is non-null when there is fragment state
        // saved from previous configurations of this activity
        // (e.g. when rotating the screen from portrait to landscape).
        // In this case, the fragment will automatically be re-added
        // to its container so we don't need to manually add it.
        // For more information, see the Fragments API guide at:
        //
        // http://developer.android.com/guide/components/fragments.html
        //
        if (savedInstanceState == null)
        {
            // Create the detail fragment and add it to the activity
            // using a fragment transaction.
            Bundle arguments = new Bundle();
            arguments.putString (   DatosDeUsuarioFragment.ARG_ITEM_ID,
                    getIntent().getStringExtra(DatosDeUsuarioFragment.ARG_ITEM_ID)
            );
            DatosDeUsuarioFragment fragment = new DatosDeUsuarioFragment();
            fragment.setArguments(arguments);
            getSupportFragmentManager() .beginTransaction()
                    .add(R.id.datos_de_usuario_vista, fragment)
                    .commit();

        }
    }
}