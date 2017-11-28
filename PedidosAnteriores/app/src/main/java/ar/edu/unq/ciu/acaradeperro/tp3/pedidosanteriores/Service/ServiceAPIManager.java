package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.Service;

import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Pedido;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model.Usuario;
import retrofit.Callback;
import retrofit.http.Body;
import retrofit.http.GET;
import retrofit.http.PUT;
import retrofit.http.Query;
import retrofit.http.Path;

public interface ServiceAPIManager {
   // @GET("/holaMundo")
    //void getXX(Callback<HolaMundo> callback);

    @GET("/pedidos/{id}")
    void getPedidoAnterior(@Path("id") String id, Callback<Pedido> callback);

    @GET("/pedidos")
    void getPedidosAnteriores(@Query("usuario") String usuario, Callback<ArrayList<Pedido>> unCallback);

    @GET("/usuarios/{nick}")
    void getUsuario(@Path("nick") String nick, Callback<Usuario> callback);

    @PUT("/usuarios/{nick}")
    void putUsuario(@Path("nick")String nick, @Body Usuario unUsuario, Callback<String> callback);


    //@GET("/pedidos/{usuario}")
    //void getPedidosAnteriores(@retrofit.http.Path("usuario") String id, Callback<List<Pedido>> callback);

    //@GET("/pedidos/{LibroId}")
    //void getPedidosAnteriores(@retrofit.http.Path("LibroId") String id, Callback<Pedido> callback);
}
