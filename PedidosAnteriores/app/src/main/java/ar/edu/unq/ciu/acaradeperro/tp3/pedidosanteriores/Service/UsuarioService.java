package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service;

import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pedido;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Usuario;
import retrofit.RestAdapter;

/**
 * Created by some on 26/11/17.
 */

public class UsuarioService {

    /*Atributos*/
    private static UsuarioService instance;
    public Usuario usuario;

    /*Constructor*/
    private UsuarioService() {   }

    /*Getters & Setters*/
    static public UsuarioService getInstance(){
        if (instance == null)
        { instance = new UsuarioService(); }
        return instance;
    }

    /*Metodos*/
    /**Crea una instancia de RestAdapter con la interface de ServiceAPIManager*/
    public ServiceAPIManager createServiceAPIManager()
    {
        String SERVER_IP = "10.0.2.15";         //esta ip se usa para comunicarse con mi localhost en el emulador de Android Studio
        String SERVER_IP_GENY = "192.168.56.1"; //esta ip se usa para comunicarse con mi localhost en el emulador de Genymotion
        String API_URL = "http://"+ SERVER_IP_GENY +":1500";

        RestAdapter restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build();
        restAdapter.setLogLevel(RestAdapter.LogLevel.FULL); //Esta solo para corroborar el correcto funcionamiento.
        return restAdapter.create(ServiceAPIManager.class);
    }

}
