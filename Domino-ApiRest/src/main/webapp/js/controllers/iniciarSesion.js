//cambio
// El nombre del controler era "sessionModel". Esta mal. Es un controler. Su responsabilidad es la de coneccion
// la responsabilidad de un modelo es la de contener la logica de negocio.
// aca no deberia haber logica de negocio.
// nos van a criticar por un error como ese, mejor evitarlo.


dominoApp.controller('SessionCrl', function($state, sesionService,pedidosService,userService) {
    return new SessionController( $state, sesionService,pedidosService,userService);
});



/* Responsabilidad */
// Conectar la vista de iniciarSesion con el modelo

function SessionController($state, sesionService, pedidosService, userService) {

    /* Atributos */

    var self = this;

    self.nick = '';
    self.pass = '';
    self.selectedUser= undefined;
    self.user= undefined;


    /*Protocolo */

    //Cambio:
    // Aca y en todos los errors handlers, el alerta usaba data.error
    // y Le era imposible manejar errores internos por que esos no vienen en forma de Data

    // antes -->

    // donde se triggereaba aparecia
    // ... .catch(self.errorHandler);

    // y el error handler hacia
    //  alert(error.data.error)


    //ahora -->
    // donde se triggerea aparece asi: function(response){ self.errorHandler(response.data)}

    this.errorHandler = function (error) {

        alert(error.error)
    };

    this.validUserCredentials = function () {

        // Cambio:
        // Pase la responsabilidad de crear el login al login service.

        // antes ->

        // var login = new Login(self.nick, self.pass) ;
        //  return sesionService.validate(login).then ...

        // ahora ->

        return sesionService.validate(self.nick, self.pass).then(self.goToPizza).catch(function(response){ self.errorHandler(response.data)});


    };

    this.goToPizza = function(user) {
        pedidosService.newPedido(user.nick);
        userService.setUserLoggin(user);
        $state.go("pizzaSelector");
    };

    this.goRegister = function() {
        $state.go("register");

    };


}
