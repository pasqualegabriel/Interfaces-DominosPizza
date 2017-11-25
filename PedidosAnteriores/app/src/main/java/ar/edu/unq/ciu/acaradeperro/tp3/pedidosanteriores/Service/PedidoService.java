package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service;

import retrofit.RestAdapter;

/**
 * Created by some on 25/11/17.
 */

public class PedidoService{

    static PedidoService instance;

    static public PedidoService getInstance(){
        if (instance == null)
        { instance = new PedidoService(); }
        return instance;
    }

    public ServiceAPIManager createServiceAPIManager()
    {
        String SERVER_IP = "10.0.2.15"; //esta ip se usa para comunicarse con mi localhost en el emulador de Android Studio
        String SERVER_IP_GENY = "192.168.56.1";//esta ip se usa para comunicarse con mi localhost en el emulador de Genymotion
        String API_URL = "http://"+ SERVER_IP +":1500";

        RestAdapter restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build();
        return restAdapter.create(ServiceAPIManager.class);
    }
}
