dominoApp.service("formaDeRetiroService", function () {
    return new RetiroService();
});


function RetiroService() {

    this.newFormaDeRetiro = function (nombreDeRetiro) {
        if(EnumFormaDeEnvio.Delivery === nombreDeRetiro)
        {
           return new FormaDeRetiro(EnumFormaDeEnvio.Delivery, "", 15);
        }
        else
        {   return new FormaDeRetiro(EnumFormaDeEnvio.Local, "", 0); }
    };
}
