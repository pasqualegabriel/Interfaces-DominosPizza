package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.Service;


import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.Pedido;
import retrofit.RestAdapter;
import retrofit.RestAdapter.LogLevel;

public class PedidoService
{
    /*Atributos*/
    private static PedidoService instance;

    /*Constructor*/

    /*Getters & Setters*/
    static public PedidoService getInstance(){
        if (instance == null)
        { instance = new PedidoService(); }
        return instance;
    }

    /*Metodos*/
    /**Crea una instancia de RestAdapter con la interface de ServiceAPIManager*/
    public ServiceAPIManager createServiceAPIManager()
    {
        String SERVER_IP = "10.0.2.15";         //esta ip se usa para comunicarse con mi localhost en el emulador de Android Studio
        String SERVER_IP_GENY = "192.168.57.1"; //esta ip se usa para comunicarse con mi localhost en el emulador de Genymotion
        String API_URL = "http://"+"10.12.14.128"+":1500";

        RestAdapter restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build();
        restAdapter.setLogLevel(LogLevel.FULL); //Esta solo para corroborar el correcto funcionamiento.
        return restAdapter.create(ServiceAPIManager.class);
    }

}
