<%-- 
    Document   : index
    Created on : 24/09/2021, 03:20:50 PM
    Author     : FERNANDO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>         
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        Bootstrap core CSS 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        Angular 
        <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>  
        <style>
            /*div {border-style: dotted; }*/
        </style>
    </head>
    <style type="text/css">
        .messages {
            color: #FA787E;
        }
        form.ng-submitted input.ng-invalid{
            border-color: #FA787E;
        }
        form input.ng-invalid.ng-touched {
            border-color: #FA787E;
        }
    </style>
    <body>
        <div class="container-fluid" ng-app="DemoS41" ng-controller="vehiculosController as vc">
            <form name="userForm" novalidate>
                <div class="row">
                    <div class="col-12">
                        <center><h1>Ingreso Vehículos</h1></center>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <h3>Sección 1</h3>
                        <div class="row">
                            <div class="col-6">
                                <label >Placa Vehículo </label>
                                <input  name="placa" class="form-control" type="text" min="0" ng-model="vc.placa" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            <div class="col-6">
                                <label >Color </label>
                                <input name="color" class="form-control" type="text" ng-model="vc.color" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label>Marca</label>
                                <input name="marca" class="form-control" type="text" ng-model="vc.marca" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                           
                        </div>
                        <div><br></div>
                        <h3>Sección 2</h3>
                        <div class="row">
                            <div class="col-3">
                                <input  class="btn btn-success" type="submit" ng-click="vc.guardarVehiculo()" value="Guardar" ng-disabled="" />
                            </div>
                            <div class="col-3">
                                <button  class="btn btn-primary" ng-click="vc.listarVehiculos()">Listar vehiculo</button>
                            </div>
                            <div class="col-3">
                                <button  class="btn btn-danger" ng-click="vc.eliminarVehiculo()">Eliminar vehiculo</button>
                            </div>
                            <div class="col-3">
                                <button  class="btn btn-warning" ng-click="vc.actualizarVehiculo()">Actualizar vehiculo</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 table-responsive-xl">
                        <h3>Sección 3</h3>
                        <table class="table table-striped table-hover">
                            <thead class="thead-dark">
                                <tr>  
                                    <th>Número de Placa</th>  
                                    <th>Color</th>  
                                    <th>Marca</th>                                     
                                </tr>  
                            </thead>
                            <tr ng-repeat = "vehiculo in vc.vehiculos">  
                                <td>{{ vehiculo.placa}}</td>  
                                <td>{{ vehiculo.color}}</td>  
                                <td>{{ vehiculo.marca}}</td>  
                      
                            </tr> 
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </body>
    <script>
        //codigo Angular
        angular.module('DemoS41', [])
                .controller('vehiculosController', ['$scope', function ($scope) {
                 
                     $scope.user = {};
                     
                     $scope.update = function () {
                            console.log($scope.user);
                        };
                        $scope.reset = function (form) {
                            $scope.user = {};
                            if (form) {
                                form.$setPristine();
                                form.$setUntouched();
                            }
                        };
                        $scope.reset();
                        
        }]);
    
        var app = angular.module('DemoS41', []);
        app.controller('vehiculosController', ['$http', controladorVehiculos]);
        
        function validar() {
            return true;
        }
        
        function controladorVehiculos($http) {
            
            var cn = this;
            
            vc.listarVehiculos = function () {
                console.log('si ingresa al Angular listar');
                var url = "Peticiones.jsp";
                var params = {
                    proceso: "listarvehiculo"
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: params
                }).then(function (res) {
                    vc.vehiculos = res.data.Vehiculos;
                });
            };
            
            vc.guardarVehiculo = function () {
                var vehiculo = {
                    proceso: "guardarVehiculo",
                    placa: vc.placa,
                    color: vc.color,
                    marca: vc.marca,
             
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: vehiculo
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[vehiculo.proceso] === true) {
                            alert("Guardado con éxito");
                            //                                                            vc.listarVehiculos();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });
            };
            
            vc.eliminarVehiculo = function () {
                var vehiculo = {
                    proceso: "eliminarvehiculo",
                    placa: vc.placa
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: vehiculo
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[vehiculo.proceso] === true) {
                            alert("Eliminado con éxito");
                            //                                vc.listarVehiculos();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });
            };
            
             vc.actualizarVehiculo = function () {
                var vehiculo = {
                    proceso: "actualizarvehiculo",
                    placa: vc.placa,
                    color: vc.color,
             
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: vehiculo
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[vehiculo.proceso] === true) {
                            alert("actualizar vehículo con éxito");
                            //                                vc.listarVehiculos();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });
            };
            
        }
        
    </script>
</html>
