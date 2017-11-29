package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.Service;

import java.util.ArrayList;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.Estado;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model.Pedido;
import retrofit.Callback;
import retrofit.http.Body;
import retrofit.http.GET;
import retrofit.http.POST;
import retrofit.http.Path;
import retrofit.http.Query;

public interface ServiceAPIManager {

    @GET("/pedidos/{id}")
    void getPedidoEnViaje(@Path("id") String id, Callback<Pedido> callback);

    @GET("/pedidos/estado")
    void getPedidosPorEstado(@Query("estado") String estado, Callback<ArrayList<Pedido>> unCallback);

    @POST("/pedidos/{id}/estado")
    void cambiarEstadoPedido(@Path("id") String idPedido, @Body Estado unEstado, Callback<String> callback);

}
