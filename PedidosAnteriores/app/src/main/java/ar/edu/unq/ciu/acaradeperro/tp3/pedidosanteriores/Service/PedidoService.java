package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service;

import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pedido;
import retrofit.RestAdapter;
import retrofit.RestAdapter.LogLevel;

public class PedidoService{

    private static PedidoService instance;
    public List<Pedido> pedidos;

    static public PedidoService getInstance(){
        if (instance == null)
        { instance = new PedidoService(); }
        return instance;
    }


    private PedidoService()
    {
        this.pedidos = new ArrayList<Pedido>();
    }

    public List<Pedido> getPedidos() {
        return this.pedidos;
    }

    public void setPedidos(List<Pedido> listaPedidos) {
        this.pedidos = listaPedidos;
    }


    public ServiceAPIManager createServiceAPIManager()
    {
        String SERVER_IP = "10.0.2.15";         //esta ip se usa para comunicarse con mi localhost en el emulador de Android Studio
        String SERVER_IP_GENY = "192.168.56.1"; //esta ip se usa para comunicarse con mi localhost en el emulador de Genymotion
        String API_URL = "http://"+ SERVER_IP_GENY +":1500";

        RestAdapter restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build();
        restAdapter.setLogLevel(LogLevel.FULL);
        return restAdapter.create(ServiceAPIManager.class);
    }
}
