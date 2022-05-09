<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>

<title>Taller 2</title>  
        <%@include file="/WEB-INF/jsp/include-js.jsp" %>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
body {
margin:0;
paddin:0;
}
.container{ 
  margin:10px;
  paddin:5px;
}
.form-style-3 {
	max-width: 450px;
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
}

label {
	display: block;
	margin-bottom: 10px;
}

label>span {
	float: left;
	width: 100px;
	color: black;
	font-weight: bold;
	font-size: 13px;
	text-shadow: 1px 1px 1px #fff;
}
  

input[type=text], input[type=date],
	 input[type=datetime], input[type=number],
	 input[type=search],  input[type=time],
	input[type=url], input[type=email],
	select, textarea {
	border-radius: 3px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border: 1px solid #1969C8;
	outline: none; 
	padding: 5px 8px 5px 8px;
	box-shadow: inset 1px 1px 4px #FFD5E7;
	-moz-box-shadow: inset 1px 1px 4px #FFD5E7;
	-webkit-box-shadow: inset 1px 1px 4px #FFD5E7;
	background: #B9D7FA;
	width: 50%;
}

.guardar{
	background: blue;
	border: 1px solid #B9D7FA;
	padding: 5px 15px 5px 15px;
	color: white; 
	font-weight: bold;
}
.guardar:hover{
	background:#127AF5;
	cursor:pointer;
}

.required {
	color: red;
	font-weight: normal;
}
.container1{
   margin-left:20%;
   margin-right:20%;
   margin-bottom:5%;
   margin-top:5%;
}
.color{
	 border-width: 2px;
  	border-style: solid;
  	border-color: blue;
	padding:10px;
	text-align:center;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container">
<h2 align=center>Listado de maestros</h2>
<table id="table_id">
  <tr>
  	<th>#</th>
    <th>Nombres</th>
    <th>Apellidos</th>
    <th>Correo</th>
    <th>Telefono</th>
    <th>Dui</th>
    <th>Eliminar</th>
    <th>Modificar</th>
  </tr> 
  <script>
		(function(window, document, $, undefined) {
			$(function() {
				var formMaestro = $("#formMaestro");
				
				formMaestro.submit(function (event) {
                    swal({
                        title: "¿Esta seguro?",
                        text: "¡Se ingresara un nuevo registro!",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#5D9CEC",
                        confirmButtonText: "Sí, guardar registro!",
                        cancelButtonText: "No, cancelar!",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }, function (isConfirm) {
                        if (isConfirm) {
                            $.ajax({
                                data: formMaestro.serialize(),
                                url: '${pageContext.request.contextPath}/guardarMaestro',
                                type: "POST",
                                success: function (response) {
                                    swal("Guardado!", "Su registro se guardo exitosamente.", "success");
                                    $("button[data-dismiss='modal']").click();
                                    formMaestro.trigger("reloadGrid");
                                    window.location.href="/taller2";
                                    return false;
                                },
                                error: function (x, e) {
                                    alert("Ocurrio un error");
                                }
                            });
                        } else {
                            swal("Cancelado", "Su petición ha sido cancelada.", "error");
                            $("button[data-dismiss='modal']").click();
                        }
                    });
                    return false;
                });

			});
		})(window, document, window.jQuery);
</script>
  
  
  <script>
  $(document).ready(function () { 
        $.ajax({
            url: "${pageContext.request.contextPath}/obtenerMaestros",
            type: "GET",
            dataType: "json",
            cache: false,
            success: function (maestros) {
                console.log('success', maestros);
                $.each(maestros, function (index, maestro) { 
                    var fila = '';
                    fila += '<tr>';
                    fila += '<td>' + maestro.idMaestro + '</td>';
                    fila += '<td>' + maestro.nombres + '</td>';
                    fila += '<td>' + maestro.apellidos + '</td>';
                    fila += '<td>' + maestro.correo + '</td>';
                    fila += '<td>' + maestro.telefono + '</td>';
                    fila += '<td>' + maestro.dui + '</td>'; 
                    fila += `<td> <button onclick="eliminarMaestro(`+maestro.idMaestro+`)">Eliminar</button> </td>`; 
                    fila += `<td> <button onClick="modificarMaestro(`+maestro.idMaestro+`)">Modificar</button> </td>`;
                    $('#table_id tbody').append(fila);
                });
            },
            error: function (data) {
                console.log(data);
            }
        });
    });
    function modificarMaestro(id){ 
    	  $.ajax({
            url: "${pageContext.request.contextPath}/obtenerMaestro/"+id,
            type: "GET",
            dataType: "json",
            cache: false,
            success: function (maestros) {  
                 var dui = document.getElementById("dui");
                 dui.disabled=false;
    			 dui.value=maestros.dui; 
    			 var nombres= document.getElementById("nombres");
    			 nombres.disabled=false;
    			 nombres.value=maestros.nombres; 
    			 var apellidos = document.getElementById("apellidos");
    			 apellidos.disabled=false;
    			 apellidos.value=maestros.apellidos; 
    			 var telefono = document.getElementById("telefono");
    			 telefono.disabled=false;
    			 telefono.value=maestros.telefono; 
    			 var correo = document.getElementById("correo");
    			 correo.disabled=false;
    			 correo.value=maestros.correo;  
    			var formMaestro = $("#formMaestroEditar"); 
				formMaestro.submit(function (event) {
                    swal({
                        title: "¿Esta seguro?",
                        text: "¡Se modificará el registro!",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#5D9CEC",
                        confirmButtonText: "Sí, guardar registro!",
                        cancelButtonText: "No, cancelar!",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }, function (isConfirm) {
                        if (isConfirm) {
                            $.ajax({
                                data: formMaestro.serialize(),
                                url: '${pageContext.request.contextPath}/modificarMaestro/'+id,
                                type: "PUT",
                                success: function (response) {
                                    swal("Guardado!", "Su registro se guardo exitosamente..", "success");
                                    $("button[data-dismiss='modal']").click();
                                    formMaestro.trigger("reloadGrid");
                                    window.location.href="/taller2";
                                    return false;
                                },
                                error: function (x, e) {
                                    alert("Ocurrio un error");
                                }
                            });
                        } else { 
                            swal("Cancelado", "Su petición ha sido cancelada.", "error");
                            $("button[data-dismiss='modal']").click();
                             window.location.href="/taller2";
                        }
                    });
                    return false;
                });
    			 	 
                
            },
            error: function (data) {
                console.log(data);
            }
         }); 
    }
    function eliminarMaestro(id){//acá mando a llamar el delete 
  		 console.log("exito"+id);
  		  $.ajax({
            url: "${pageContext.request.contextPath}/eliminarMaestro/"+id, 
            type: "DELETE", 
            contentType: "application/json",
        	dataType : 'json',
            success:function(result){ 
            	alert("Eliminado Correctamente"); 
            	window.location.href="/taller2/";
            },
            error: function(data){
            	console.log(data);
            }
         });
  	}
  </script>
</table>
</div>

<div class="container1">
		<form role="form" id="formMaestroEditar" data-toggle="validator"> 
			<div class="color">
			<h2>Modificar Maestro</h2> 
				<label for="nombre">
					<span>Nombres</span>
					<input type="text" disabled class="input-field"name="nombres" id="nombres" required/>
				</label> 
				<label for="apellido">
					<span>Apellidos</span>
					<input type="text" disabled class="input-field"name="apellidos" id="apellidos" required/>
				</label> 
				<label for="correo">
					<span>Correo</span>
					<input type="text" disabled class="input-field" name="correo" id="correo" required/>
				</label>
				<label for="telefono">
					<span>Telefono</span>
					<input type="text" disabled placeholder="____-____" class="input-field" name="telefono" id="telefono" required/>
					<script>
                        $(document).ready(function () {
                            $("#telefono").mask("9999-9999", {placeholder: "____-____", autoclear: true});
                        });
                    </script>
				</label>  
				<label for="dui">
					<span>Dui</span>
					<input type="text" disabled placeholder="________-_" class="input-field" name="dui" id="dui" required/>
					 <script>
                        $(document).ready(function () {
                            $("#dui").mask("99999999-9", {placeholder: "________-_", autoclear: true});
                        });
                    </script>
				</label>  
				<button id="btn-guardar" type="submit" class="guardar">Guardar</button>
			</div> 
		</form>
	</div> 
	<div class="container1">
	<form role="form" id="formMaestro" data-toggle="validator"> 
			<div class="color">
			<h2>Agregar Maestro</h2> 
				<label for="nombre">
					<span>Nombres</span>
					<input type="text" class="input-field"name="nombres" required/>
				</label> 
				<label for="apellido">
					<span>Apellidos</span>
					<input type="text" class="input-field"name="apellidos" required/>
				</label> 
				<label for="correo">
					<span>Correo</span>
					<input type="text" class="input-field" name="correo" required/>
				</label>
				<label for="telefono">
					<span>Telefono</span>
					<input type="text" placeholder="____-____" class="input-field" name="telefono" id="telefono1" required/>
					<script>
                        $(document).ready(function () {
                            $("#telefono1").mask("9999-9999", {placeholder: "____-____", autoclear: true});
                        });
                    </script>
				</label>  
				<label for="dui">
					<span>Dui</span>
					<input type="text" placeholder="________-_" class="input-field" name="dui" id="dui1" required/>
					 <script>
                        $(document).ready(function () {
                            $("#dui1").mask("99999999-9", {placeholder: "________-_", autoclear: true});
                        });
                    </script>
				</label>  
				<button id="btn-guardar" type="submit" class="guardar">Guardar</button>
			</div> 
		</form>
	</div>
</body>
</html>
