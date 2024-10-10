Public Class Envio
    Inherits EntidadBase

    Public Sub New()
        _detalle = New List(Of ItemEnvio)
    End Sub

    Public Overridable Property Cliente As Cliente

    Public Overridable Property DireccionDestino As String

    Public Overridable Property Provincia As Provincia

    Public Overridable Property ProveedorPaqueteria As String

    Private _estadoEnvio As String

    Public Overridable Property EstadoEnvio As String
        Get
            Return _estadoEnvio
        End Get
        Private Set(value As String)
            _estadoEnvio = value
        End Set
    End Property


    Public Overridable Property FechaEnvio As Date

    Public Overridable Property CodigoSeguimiento As String

    Private _detalle As IList(Of ItemEnvio)

    Public Overridable ReadOnly Property Detalle As IEnumerable(Of ItemEnvio)
        Get
            Return _detalle.AsEnumerable()
        End Get
    End Property


    Public Overridable Sub ActualizarEstado(nuevoEstado As String)
        Me.EstadoEnvio = nuevoEstado

        If nuevoEstado = EstadoEnvioEnum.EN_TRANSITO Then
            Me.CodigoSeguimiento = Guid.NewGuid().ToString()
        End If
    End Sub

End Class
