Option Explicit On

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
            Else
                Me.Detalle = New List(Of ItemEnvioEdicionDTOParaGrilla)
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

    Private Property Detalle As List(Of ItemEnvioEdicionDTOParaGrilla)
        Get
            Return DirectCast(Session("envios_envio_edicion_Detalle"), IList(Of ItemEnvioEdicionDTOParaGrilla))
        End Get
        Set(value As List(Of ItemEnvioEdicionDTOParaGrilla))
            Session("envios_envio_edicion_Detalle") = value
        End Set
    End Property

    Public Class ItemEnvioEdicionDTOParaGrilla
        Inherits ItemEnvioEdicionDTO

        Public Sub New()
            Me.GridID = Guid.NewGuid()
        End Sub

        Private _gridID As Guid

        Public Property GridID As Guid
            Private Set(value As Guid)
                _gridID = value
            End Set
            Get
                Return _gridID
            End Get
        End Property
    End Class


    Private Sub _EnlazarEnvio()
        Dim envioDTO As EnvioEdicionVistaDTO = New EnvioService().TraerParaEdicion(Me.IdEnvio.Value)

        cmbCliente.Value = envioDTO.ClienteID
        txtDireccion.Value = envioDTO.DireccionDestino
        txtProveedorPaqueteria.Value = envioDTO.ProveedorPaqueteria
        cmbProvincia.Value = envioDTO.ProvinciaID
        dtFecha.Value = envioDTO.FechaEnvio
        lblCodigoSeguimiento.Value = envioDTO.CodigoSeguimiento
        lblEstado.Value = envioDTO.EstadoEnvio

        Me.Detalle = (From itemDTO In envioDTO.Detalle
                      Select New ItemEnvioEdicionDTOParaGrilla With {
                          .ID = itemDTO.ID,
                          .DescripcionBulto = itemDTO.DescripcionBulto,
                          .Peso = itemDTO.Peso,
                          .Dimensiones = itemDTO.Dimensiones
                     }).ToList()

        gvDetalleEnvio.DataBind()
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

                envioDTO.Detalle = Me.Detalle.Cast(Of ItemEnvioEdicionDTO)().ToList()

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

    Protected Sub gvDetalleEnvio_DataBinding(sender As Object, e As EventArgs)
        DirectCast(sender, ASPxGridView).DataSource = Me.Detalle
    End Sub

    Protected Sub gvDetalleEnvio_RowInserting(sender As Object, e As Data.ASPxDataInsertingEventArgs)
        e.Cancel = True

        Me.Detalle.Add(New ItemEnvioEdicionDTOParaGrilla() With {
            .DescripcionBulto = e.NewValues("DescripcionBulto"),
            .Dimensiones = e.NewValues("Dimensiones"),
            .Peso = CDec(e.NewValues("Peso"))
        })

        gvDetalleEnvio.CancelEdit()
    End Sub

    Protected Sub gvDetalleEnvio_RowDeleting(sender As Object, e As Data.ASPxDataDeletingEventArgs)
        Dim gridID As Guid = e.Keys(gvDetalleEnvio.KeyFieldName)
        Dim itemDTO As ItemEnvioEdicionDTOParaGrilla = Me.Detalle.Where(Function(i) i.GridID = gridID).Single()
        Me.Detalle.Remove(itemDTO)

        e.Cancel = True
    End Sub

    Protected Sub gvDetalleEnvio_RowUpdating(sender As Object, e As Data.ASPxDataUpdatingEventArgs)
        Dim gridID As Guid = e.Keys(gvDetalleEnvio.KeyFieldName)

        Dim itemDTO As ItemEnvioEdicionDTOParaGrilla = Me.Detalle.Where(Function(i) i.GridID = gridID).Single()

        itemDTO.DescripcionBulto = e.NewValues("DescripcionBulto")
        itemDTO.Dimensiones = e.NewValues("Dimensiones")
        itemDTO.Peso = CDec(e.NewValues("Peso"))

        e.Cancel = True

        gvDetalleEnvio.CancelEdit()
    End Sub
End Class
