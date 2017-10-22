iniciarSesionLoca.service("TareasService", function () {

  this.tareasIds = 0;
  this.tareas = [];

  this.crearTarea = function (description) {
    var tarea = new Tarea(description);
    tarea.id = this.tareasIds++;
    return tarea;
  };

  this.agregarTarea = function (tarea) {
    this.tareas.push(tarea);
  };

  this.getTareaById = function (id) {
    return _.find(this.tareas, function (tarea) {
      return tarea.id == id;
    })
  };

});