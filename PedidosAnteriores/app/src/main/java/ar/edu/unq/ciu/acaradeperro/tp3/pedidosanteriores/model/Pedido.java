package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Pedido implements Serializable{

    Integer id;
    String estadoActual;
    String miembro;
    List<Plato> platos;
    String fecha;
    String aclaracion;
    FormaDeRetiro formaDeRetiro;
    Double monto;
    Integer tiempoDeEspera;

    public Pedido()
    {
        this.id         = 0;
        estadoActual    = "";
        miembro         = "";
        platos          = new ArrayList<>();
        fecha           = "";
        aclaracion      = "";
        formaDeRetiro   = new FormaDeRetiro();
        monto           = 0.0;
        tiempoDeEspera  = 0;
    }

    public String titulo() {
        return "Pedido del dia: " + this.fecha;
    }

    public String toString()
    {   return this.titulo();  }

    public String direccionDeRetiro()
    {   return this.getFormaDeRetiro().getDireccion();   }

/*Getters & Setters*/
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEstadoActual() {
        return estadoActual;
    }

    public void setEstadoActual(String estadoActual) {
        this.estadoActual = estadoActual;
    }

    public String getMiembro() {
        return miembro;
    }

    public void setMiembro(String miembro) {
        this.miembro = miembro;
    }

    public List<Plato> getPlatos() {
        return platos;
    }

    public void setPlatos(List<Plato> platos) {
        this.platos = platos;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getAclaracion()
    {
        if (this.aclaracion.isEmpty())
        { return "-";}
        else
        {return aclaracion;}
    }

    public void setAclaracion(String aclaracion) {
        this.aclaracion = aclaracion;
    }

    public FormaDeRetiro getFormaDeRetiro() {
        return formaDeRetiro;
    }

    public void setFormaDeRetiro(FormaDeRetiro formaDeRetiro) {
        this.formaDeRetiro = formaDeRetiro;
    }

    public Double getMonto() {
        return monto;
    }

    public void setMonto(Double monto) {
        this.monto = monto;
    }

    public Integer getTiempoDeEspera() {
        return tiempoDeEspera;
    }

    public void setTiempoDeEspera(Integer tiempoDeEspera) {
        this.tiempoDeEspera = tiempoDeEspera;
    }

}
