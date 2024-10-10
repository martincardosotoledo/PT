
Imports DevExpress.Web
Imports PT.Services

Partial Class envios_envio_edicion
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not IsPostBack Then
            cmbCliente.DataBind()
            cmbProvincia.DataBind()

            If Me.IdEnvio.HasValue Then
                _EnlazarEnvio()
            End If
        End If
    End Sub

    ReadOnly Property IdEnvio As Nullable(Of Integer)
        Get
            If Not String.IsNullOrWhiteSpace(Request.QueryString("id")) Then
                Return Integer.Parse(Request.QueryString("id"))
            Else
                Return Nothing
            End If
        End Get
    End Property

    Private Sub _EnlazarEnvio()
        Dim envioDTO As EnvioEdicionVistaDTO = New EnvioService().TraerParaEdicion(Me.IdEnvio.Value)

        cmbCliente.Value = envioDTO.ClienteID
        txtDireccion.Value = envioDTO.DireccionDestino
        cmbProvincia.Value = envioDTO.ProvinciaID
        dtFecha.Value = envioDTO.FechaEnvio
        lblCodigoSeguimiento.Value = envioDTO.CodigoSeguimiento
        lblEstado.Value = envioDTO.EstadoEnvio
    End Sub

    Protected Sub cmbCliente_DataBinding(sender As Object, e As EventArgs)
        DirectCast(sender, ASPxComboBox).DataSource = New ClienteServices().TraerTodos().OrderBy(Function(c) c.Descripcion)
    End Sub

    Protected Sub cmbProvincia_DataBinding(sender As Object, e As EventArgs)
        DirectCast(sender, ASPxComboBox).DataSource = New ProvinciaService().TraerTodos().OrderBy(Function(c) c.Descripcion)
    End Sub

    Protected Sub clbComandos_Callback(source As Object, e As CallbackEventArgs)
        If e.Parameter = "GUARDAR" Then
            If ASPxEdit.ValidateEditorsInContainer(flyEdicion) Then
                Dim envioService As New EnvioService()

                Dim envioDTO As New EnvioEdicionDTO()

                envioDTO.ID = Me.IdEnvio

                envioDTO.ClienteID = cmbCliente.Value
                envioDTO.DireccionDestino = txtDireccion.Text.Trim()
                envioDTO.ProvinciaID = cmbProvincia.Value
                envioDTO.FechaEnvio = dtFecha.Date
                envioDTO.ProveedorPaqueteria = txtProveedorPaqueteria.Text.Trim()
                Try
                    envioService.GuardarEnvio(envioDTO)

                    clbComandos.JSProperties.Add("cpGuardadoOK", 1)
                Catch ex As FluentValidation.ValidationException
                    clbComandos.JSProperties.Add("cpGuardadoErrores", String.Join("<br \>", (From err In ex.Errors
                                                                                             Select String.Format("-{0}", err.ErrorMessage))))
                End Try

            End If
        End If
    End Sub
End Class
