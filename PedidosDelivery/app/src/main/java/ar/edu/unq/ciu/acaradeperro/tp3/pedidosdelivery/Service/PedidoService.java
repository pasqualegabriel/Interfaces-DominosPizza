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
    public List<Pedido> pedidosEnViaje;

    /*Constructor*/
    private PedidoService() {   this.pedidosEnViaje = new ArrayList<Pedido>(); }

    /*Getters & Setters*/
    static public PedidoService getInstance(){
        if (instance == null)
        { instance = new PedidoService(); }
        return instance;
    }

    public List<Pedido> getPedidos() {  return this.pedidosEnViaje;    }

    public void setPedidos(List<Pedido> listaPedidos) { this.pedidosEnViaje = listaPedidos;    }

    /*Metodos*/
    /**Crea una instancia de RestAdapter con la interface de ServiceAPIManager*/
    public ServiceAPIManager createServiceAPIManager()
    {
        String SERVER_IP = "10.0.2.15";         //esta ip se usa para comunicarse con mi localhost en el emulador de Android Studio
        String SERVER_IP_GENY = "192.168.57.1"; //esta ip se usa para comunicarse con mi localhost en el emulador de Genymotion
        String API_URL = "http://"+ SERVER_IP_GENY+":1500";

        RestAdapter restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build();
        restAdapter.setLogLevel(LogLevel.FULL); //Esta solo para corroborar el correcto funcionamiento.
        return restAdapter.create(ServiceAPIManager.class);
    }

    public boolean hayPedidos()
    {   return this.getPedidos().size() > 0;    }

    public void quitarPedido(int unPedidoId)
    {
        List<Pedido> listaARevisar = this.pedidosEnViaje;

        for ( Pedido pedido : listaARevisar)
        {
            if(pedido.getId() == unPedidoId)
            {this.pedidosEnViaje.remove(pedido);}
        }
    }
}
