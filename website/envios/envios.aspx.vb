
Imports DevExpress.Web
Imports PT.Services

Partial Class envios_frmEnvios
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not IsPostBack Then
            gvEnvios.DataBind()
            cmbEstado.DataBind()
        End If
    End Sub


    Protected Sub btnEditar_Init(sender As Object, e As EventArgs)
        Dim btn As ASPxButton = DirectCast(sender, ASPxButton)

        Dim c = DirectCast(btn.NamingContainer, GridViewDataItemTemplateContainer)

        btn.JSProperties.Add("cpId", gvEnvios.GetRowValues(c.VisibleIndex, "EnvioID"))
    End Sub

    Protected Sub gvEnvios_DataBinding(sender As Object, e As EventArgs)
        gvEnvios.DataSource = New EnviosServices().TraerEnviosParaListar()
    End Sub

    Protected Sub gvEnvios_RowDeleting(sender As Object, e As Data.ASPxDataDeletingEventArgs)
        e.Cancel = True

        Dim envioID As Integer = Convert.ToInt32(e.Keys(gvEnvios.KeyFieldName))

        Call New EnviosServices().Eliminar(envioID)
    End Sub
    Protected Sub gvDetalleEnvio_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Dim grillaDetalle As ASPxGridView = DirectCast(sender, ASPxGridView)
        grillaDetalle.DataSource = New EnviosServices().TraerDetalle(Convert.ToInt32(grillaDetalle.GetMasterRowKeyValue()))
    End Sub

    Protected Sub cmbEstado_DataBinding(sender As Object, e As EventArgs)
        cmbEstado.DataSource = New EnviosServices().TraerEstados()
    End Sub

    Protected Sub btnActualizarEstado_Init(sender As Object, e As EventArgs)
        Dim btn As ASPxButton = DirectCast(sender, ASPxButton)

        Dim c = DirectCast(btn.NamingContainer, GridViewDataItemTemplateContainer)

        btn.JSProperties.Add("cpId", gvEnvios.GetRowValues(c.VisibleIndex, "EnvioID"))
    End Sub

    Protected Sub popCambiarEstado_WindowCallback(source As Object, e As PopupWindowCallbackArgs)
        If e.Parameter.StartsWith("ACTUALIZAR_ESTADO") Then
            Call New EnviosServices().ActualizarEstado(Integer.Parse(e.Parameter.Split("|")(1)), cmbEstado.Value)

            popCambiarEstado.JSProperties.Add("cpEstadoActualizado", 1)
        Else
            cmbEstado.Value = New EnviosServices().TraerEstado(Integer.Parse(e.Parameter))

            popCambiarEstado.JSProperties.Add("cpPopupCambioEstadoEnlazado", 1)
        End If
    End Sub
End Class
