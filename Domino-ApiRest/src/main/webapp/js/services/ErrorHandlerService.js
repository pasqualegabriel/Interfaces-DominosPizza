dominoApp.service("errorHandler", ErrorHandler);


function ErrorHandler($timeout) {

    // FEEDBACK & ERRORES
    this.msgs = [];
    this.errors = [];

    this.notificarMensaje = function(mensaje) {
        this.msgs.push(mensaje);
        this.notificar(this.msgs);
    };

    this.notificarError = function(mensaje) {
        this.errors.push(mensaje);
        this.notificar(this.errors);
    };

    this.notificar = function(mensajes) {
        $timeout(function() {
            while (mensajes.length > 0) mensajes.pop();
        }, 7500);
    };

}
