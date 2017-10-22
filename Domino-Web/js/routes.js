inicioSesion.config(function ($stateProvider, $urlRouterProvider) {


  $stateProvider

      .state('iniciarSesion',{
        url:"/ini",
        templateUrl: "../partials/iniciarSesion.html"

      })

      .state('registrarse', {
      url: "/a",
      templateUrl: "../partials/registrarse.html"
    })

      .state('editarPizza1', {
      url: "/EditorPizza",
      templateUrl: "../partials/editarPizza1.html"
    })

    .state('editarPizza2', {
        url: "/EditorPizza/two",
        templateUrl: "../partials/editarPizza2.html"
    });

    $urlRouterProvider.otherwise("/ini");

});
