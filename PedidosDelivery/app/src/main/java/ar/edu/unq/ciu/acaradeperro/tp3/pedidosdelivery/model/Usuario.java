package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model;

/**
 * Created by some on 26/11/17.
 */

public class Usuario {

    String nombre;
    String direccion;
    String mail;

    public Usuario (){}


    public  String getNombre() {
        return nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getMail() {
        return mail;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }
}
