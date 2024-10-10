Imports PT.DataAccess
Imports PT.Dominio
Imports PT.DTOs

Public Class EnviosServices
    Inherits ServicioBase


    Public Function TraerEnviosParaListar() As List(Of EnvioDTO)
        Return (From e In New EnvioRepositorio().GetAll()
                Select New EnvioDTO() With {
                    .EnvioID = e.ID,
                    .Cliente = e.Cliente.Nombre,
                    .Provincia = e.Provincia.Nombre,
                    .ConDetalle = e.Detalle.Any()
               }).ToList()
    End Function

    Public Sub Eliminar(envioID As Integer)
        Dim repo As New EnvioRepositorio()

        repo.Delete(envioID)
    End Sub

    Public Function TraerDetalle(envioID As Integer) As List(Of ItemDetalleEnvioDTO)
        Dim envio As Envio = New EnvioRepositorio().GetById(envioID)

        Return (From ie In envio.Detalle
                Select New ItemDetalleEnvioDTO With {
                    .DescripcionBulto = ie.DescripcionBulto,
                    .Peso = ie.Peso,
                    .Dimensiones = ie.Dimensiones}).ToList()
    End Function

    Public Function TraerEstados() As List(Of String)
        Return {EstadoEnvioEnum.PENDIENTE, EstadoEnvioEnum.EN_TRANSITO, EstadoEnvioEnum.ENTREGADO}.ToList()
    End Function

    Public Function TraerEstado(envioID As Integer) As String
        Dim envio As Envio = New EnvioRepositorio().GetById(envioID)
        Return envio.EstadoEnvio
    End Function

    Public Sub ActualizarEstado(envioID As Integer, nuevoEstado As String)
        Dim envio As Envio = New EnvioRepositorio().GetById(envioID)
        envio.ActualizarEstado(nuevoEstado)
    End Sub

End Class




Public Class ItemDetalleEnvioDTO

    Public Property DescripcionBulto As String

    Public Property Peso As Decimal

    Public Property Dimensiones As String
End Class
