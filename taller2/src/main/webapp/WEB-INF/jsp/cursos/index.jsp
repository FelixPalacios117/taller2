<%@ page contentType="text/html;charset=UTF-8" language="java"%> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Taller 2</title> <%@include file="/WEB-INF/jsp/include-js.jsp" %>
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
	margin: 0;
	paddin: 0;
}

.container {
	margin: 10px;
	paddin: 5px;
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

input[type=text], input[type=date], input[type=datetime], input[type=number],
	input[type=search], input[type=time], input[type=url], input[type=email],
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

.guardar {
	background: blue;
	border: 1px solid #B9D7FA;
	padding: 5px 15px 5px 15px;
	color: white;
	font-weight: bold;
}

.guardar:hover {
	background: #127AF5;
	cursor: pointer;
}

.required {
	color: red;
	font-weight: normal;
}

.container1 {
	margin-left: 20%;
	margin-right: 20%;
	margin-bottom: 5%;
	margin-top: 5%;
}

.color {
	border-width: 2px;
	border-style: solid;
	border-color: blue;
	padding: 10px;
	text-align: center;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/jsp/navbar.jsp" %>
	<div class="container">
		<h2 align=center>Cursos</h2>
		<table id="table_id">
			<tr>
				<th>#</th>
				<th>Descripcion</th>
				<th>Grado</th>
				<th>Seccion</th>
				<th>Maestro</th>
				<th>Materia</th>
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
                                url: '${pageContext.request.contextPath}/guardarCurso',
                                type: "POST",
                                success: function (response) {
                                    swal("Guardado!", "Su registro se guardo exitosamente.", "success");
                                    $("button[data-dismiss='modal']").click();
                                    formMaestro.trigger("reloadGrid");
                                    window.location.href="/taller2/cursos";
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
            url: "${pageContext.request.contextPath}/obtenerCursos",
            type: "GET",
            dataType: "json",
            cache: false,
            success: function (cursos) {
                console.log('success', cursos);
                $.each(cursos, function (index, curso) { 
                    var fila = '';
                    fila += '<tr>';
                    fila += '<td>' + curso.idCurso + '</td>';
                    fila += '<td>' + curso.descripcion + '</td>';
                    fila += '<td>' + curso.grado + '</td>';
                    fila += '<td>' + curso.seccion + '</td>';
                    fila += '<td>' + curso.idMaestro + '</td>';
                    fila += '<td>' + curso.materia + '</td>'; 
                    fila += `<td> <button onclick="eliminarCurso(`+curso.idCurso+`)">Eliminar</button> </td>`; 
                    fila += `<td> <button onClick="modificarCurso(`+curso.idCurso+`)">Modificar</button> </td>`;
                    $('#table_id tbody').append(fila);
                });
            },
            error: function (data) {
                console.log(data);
            }
        });
    });
    function modificarCurso(id){ 
    	  $.ajax({
            url: "${pageContext.request.contextPath}/obtenerCurso/"+id,
            type: "GET",
            dataType: "json",
            cache: false,
            success: function (curso) {  
                 var descripcion = document.getElementById("descripcion");
                 descripcion.disabled=false;
    			 descripcion.value=curso.descripcion; 
    			 var grado= document.getElementById("grado");
    			 grado.disabled=false;
    			 grado.value=curso.grado; 
    			 var seccion = document.getElementById("seccion");
    			 seccion.disabled=false;
    			 seccion.value=curso.seccion; 
    			 var maestro = document.getElementById("maestro");
    			 maestro.disabled=false;
    			 maestro.value=curso.idMaestro; 
    			 var materia = document.getElementById("materia");
    			 materia.disabled=false;
    			 materia.value=curso.materia;  
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
                                url: '${pageContext.request.contextPath}/modificarCurso/'+id,
                                type: "PUT",
                                success: function (response) {
                                    swal("Guardado!", "Su registro se guardo exitosamente..", "success");
                                    $("button[data-dismiss='modal']").click();
                                    formMaestro.trigger("reloadGrid");
                                    window.location.href="/taller2/cursos";
                                    return false;
                                },
                                error: function (x, e) {
                                    alert("Ocurrio un error");
                                }
                            });
                        } else { 
                            swal("Cancelado", "Su petición ha sido cancelada.", "error");
                            $("button[data-dismiss='modal']").click();
                             window.location.href="/taller2/cursos";
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
    function eliminarCurso(id){//acá mando a llamar el delete 
  		 console.log("exito"+id);
  		  $.ajax({
            url: "${pageContext.request.contextPath}/eliminarCurso/"+id, 
            type: "DELETE", 
            contentType: "application/json",
        	dataType : 'json',
            success:function(result){ 
            	alert("Eliminado Correctamente"); 
            	window.location.href="/taller2/cursos";
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
				<h2>Modificar Curso</h2>
				<label for="descripcion"> 
					<span>Descripcion</span> 
					<input type="text" disabled class="input-field" name="descripcion" id="descripcion" required />
				</label> 
				<label for="grado"> 
					<span>Grado</span> 
					<input type="text" disabled class="input-field" name="grado" id="grado" required />
				</label> 
				<label for="seccion"> 
					<span>Seccion</span> 
					<input type="text" disabled class="input-field" name="seccion" id="seccion" required /> 
				</label>
				<label for="maestro">
					<span>Maestro</span>
					<input type="text" name="maestro" id="maestro" disabled required />
				</label> 
				<label for=materia> 
					<span>Materia</span>
					<input type="text" disabled class="input-field" name="materia" id="materia" required />
				</label>
				<button id="btn-guardar" type="submit" class="guardar">Guardar</button>
			</div>
		</form>
	</div>
	<div class="container1">
		<form role="form" id="formMaestro" data-toggle="validator">
			<div class="color">
				<h2>Agregar Curso</h2>
				<label for="descripcion"> 
					<span>Descripcion</span> 
					<input type="text"  class="input-field" name="descripcion" id="descripcion" required />
				</label> 
				<label for="grado"> 
					<span>Grado</span> 
					<input type="text"  class="input-field" name="grado" id="grado" required />
				</label> 
				<label for="seccion"> 
					<span>Seccion</span> 
					<input	type="text"  class="input-field" name="seccion" id="seccion" required /> 
				</label>
				<label for="maestro">
					<span>Maestro</span>
					<input type="text" class="input-field"  name="maestro" id="maestro" required />
				</label>
				 <label for=materia>
				 	<span>Materia</span>
				 	<input type="text" class="input-field" name="materia" id="materia" required />
				</label>
					<button id="btn-guardar" type="submit" class="guardar">Guardar</button>
			</div>
		</form>
	</div>
</body>
</html>