<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head> 
 <%@include file="/WEB-INF/jsp/include-js.jsp" %>
 <script>

		(function(window, document, $, undefined) {
			$(function() {
				var formPerson = $("#formPerson");
				
				formPerson.submit(function (event) {
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
                                data: formPerson.serialize(),
                                url: '${pageContext.request.contextPath}/savePerson',
                                type: "POST",
                                success: function (response) {
                                    swal("Guardado!", "Su registro se guardo exitosamente.", "success");
                                    $("button[data-dismiss='modal']").click();
                                    formPerson.trigger("reloadGrid");
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
</head>
<body class="skin-megna fixed-layout">
	<div class="preloader">
		<div class="loader">
			<div class="loader__figure"></div>
			<p class="loader__label">ADMIN</p>
		</div>
	</div>
	<div id="main-wrapper">
		<%@include file="/WEB-INF/jsp/header.jsp" %>
		<%@include file="/WEB-INF/jsp/menu.jsp" %>
		<div class="page-wrapper">
         	<div class="container-fluid">
					<div class="row page-titles">
                        <div class="col-md-5 align-self-center">
                            <h4 class="text-themecolor"></h4>
                        </div>
                        <div class="col-md-7 align-self-center text-right">
                            <div class="d-flex justify-content-end align-items-center">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="javascript:void(0)">Index</a></li>
                                    <li class="breadcrumb-item active">Person</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                    <div>
 						<form role="form" id="formPerson" data-toggle="validator">
                            <div class="row" >
                                <div class="col-md-6">
                                    <label class="control-label">Id</label>
                                    <input class="form-control"   type="text" name="idPerson" id="idPerson" />
                                </div>
                                <div class="col-md-6">
                                    <label class="control-label">Nombre</label>
                                    <input class="form-control" required="true"  type="text" name="nombre" id="nombre"/>
                                </div>
                            </div>
                            <div class="row" >
                                <div class="col-md-12">
                                    <label class="control-label">Correo</label>
                                    <input class="form-control"   type="text" name="correo" id="correo" />
                                </div>
                            </div>
                            <div class="row" >
                                <div class="col-md-6">
                                    <label class="control-label">Direcci&oacute;n</label>
                                    <input class="form-control"   type="text" name="direccion" id="direccion"/>
                                </div>
                                <div class="col-md-6">
                                    <label class="control-label">Tel&eacute;fono 1</label>
                                    <input class="form-control"    type="text" name="telefono" id="telefono" />
                                    <script>
                                        $(document).ready(function () {
                                            $("#telefono").mask("9999-9999", {placeholder: "____-____", autoclear: true});
                                        });
                                    </script>
                                </div>
                            </div>
                            <div class="row" >
                                <div class="col-md-6">
                                    <label>Departamento</label>
                                     <select id="catDepartamentoDelegate"  name="departamento.idDepartamento" required="true"  class="form-control "  style="width: 100%;" ></select> 
									<script>
									  $(document).ready(function () {
									      $('#catDepartamentoDelegate').select2({ allowClear: false});
									      $.getJSON("/springform/cbofilterDepartamento", function (result) {
									          $.each(result, function () {
									              $("#catDepartamentoDelegate").append(new Option(this.description, this.value));
									          });
									      $("#catDepartamentoDelegate").val("null").trigger('change');
									      });
									  });
									</script>
                                    <script>
                                        $("#catDepartamentoDelegate").on('change', (function () {

                                            if ($("#catDepartamentoDelegate").val() != null) {
                                                $('#catMunicipioDelegate').empty();

                                                $.getJSON("/springform/cbofilterMunicipioByDep?idDepartamento=" + $("#catDepartamentoDelegate").val(), function (result) {
                                                    $.each(result, function () {
                                                        $("#catMunicipioDelegate").append(new Option(this.description, this.value));
                                                    });
                                                });
                                                $('#catMunicipioDelegate').trigger('change');
                                            }
                                        }));
                                    </script>
                                </div>
                                <div class="col-md-6">
                                    <label>Municipio</label>
                                     <select id="catMunicipioDelegate"  name="municipio.idMunicipio" required="true"  class="form-control "  style="width: 100%;" ></select> 
									<script>
									  $(document).ready(function () {
									      $('#catMunicipioDelegate').select2({ allowClear: false});
									      $.getJSON("${pageContext.request.contextPath}/cbofilterMunicipio", function (result) {
									          $.each(result, function () {
									              $("#catMunicipioDelegate").append(new Option(this.description, this.value));
									          });
									      $("#catMunicipioDelegate").val("null").trigger('change');
									      });
									  });
									</script>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Cancelar</button>
                                <button id="btn-save" type="submit"  class="btn btn-success waves-effect waves-light save-category" >Guardar</button>
                            </div>
                        </form>
					</div>
                </div>
            </div>
            <%@include file="/WEB-INF/jsp/footer.jsp" %>
	</div>
</body>
</html>