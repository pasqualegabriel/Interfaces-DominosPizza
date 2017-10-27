'use strict';

/* Controllers */

var dominoApp = angular.module('dominoApp', [ 'ui.router']);


function User(aName, aNick, aPassword, aMail, aDir) {

    this.nombre= aName;
    this.nick = aNick;
    this.password = aPassword;
    this.mail = aMail;
    this.direccion = aDir;
    this.historialDePedidos = [];

}

function Tamanio(aName, aFactor) {
    this.nombre             = aName;
    this.factorDeTamanio    = aFactor;

}

function Ingrediente(aName, aPrecio) {
    this.nombre     = aName;
    this.precio     = aPrecio;

}

function Pedido(unId, unMiembro){
    this.id             = unId;
    this.estadoActual   = "";
    this.miembro        = unMiembro;
    this.platos         = [];
    this.fecha          = "";
    this.aclaracion     = "";
    this.formaDeRetiro  = "";
    this.monto          = "";
    this.tiempoDeEspera = "";
}


function FormaDeRetiro(unTipo, unaDireccion){
    this.tipo             = unTipo;
    this.direccion        = unaDireccion;
}


function Pizza(aName, aDescription, aPrecio) {

    this.nombre         = aName;
    this.precioBase     = aPrecio;
    this.distribucion   = new DistribucionEnPizza();
    this.descripcion    = aDescription;

    this.addIngrediente = function (unIngrediente, unaDistribucion) {
        this.distribucion.addIngrediente(unIngrediente,unaDistribucion)
    };

    this.getDistribuciones = function() {
        return this.distribucion;
    }
    /*
        this.descripcion = function () {
            return this.nombre + this.distribucion.forEach(function (t) {
                t.ingrediente()
            });

        }*/
}

function DistribucionEnPizza() {
    this.ingredientes = [];

    this.addIngrediente = function (unIngrediente, unaDistribucion) {
        this.ingredientes.push(new PairIngredienteDistribucionPizza(unIngrediente, unaDistribucion))
    };
}

function PairIngredienteDistribucionPizza(aIng, aDir) {
    this.ingrediente     = aIng;
    this.distribucion    = aDir;

}

function Distribucion() {
    this.distribucion    = "";
}

function Plato(unaPizza){
    this.pizza               = unaPizza;
    this.tamanio             = "";
    this.ingredientesExtras  = new DistribucionEnPizza();
}


function Sesion(aUser) {
    this.nick = aUser.nick;
    this.password = aUser.password;
}