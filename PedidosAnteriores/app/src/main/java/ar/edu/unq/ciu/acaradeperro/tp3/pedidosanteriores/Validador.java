package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores;

import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.excepciones.DireccionException;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.excepciones.EmailException;
import ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.excepciones.NombreException;

/**
 * Created by Victor on 27/11/2017.
 */
class Validador
{
    /*Atributos*/
    private static Validador instance;

    /*Constructor*/
    private Validador()
    {}

    /*Getters & Setters*/
    static public Validador getInstance(){
        if (instance == null)
        { instance = new Validador(); }
        return instance;
    }

    public void tieneDatos(String valorAValidar) throws NombreException
    {
        if (valorAValidar.isEmpty())
        {   throw new NombreException("No Hay Datos");   }
    }

    public void tieneDireccion(String valorAValidar) throws DireccionException
    {
        if (valorAValidar.isEmpty())
        {   throw new DireccionException("No Hay Direccion");   }
    }

    public void tieneEmail(String valorAValidar) throws EmailException
    {
        if (valorAValidar.isEmpty() || !valorAValidar.contains("@"))
        {   throw new EmailException("No Hay Mail");   }
    }


}
