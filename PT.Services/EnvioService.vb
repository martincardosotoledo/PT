Imports FluentValidation
Imports PT.DataAccess
Imports PT.Dominio
Imports PT.DTOs

Public Class EnvioService
    Inherits ServicioBase


    Public Function TraerEnviosParaListar() As List(Of EnvioDTO)
        Return (From e In New EnvioRepositorio().GetAll()
                Select New EnvioDTO() With {
                    .EnvioID = e.ID,
                    .Cliente = e.Cliente.Nombre,
                    .Provincia = e.Provincia.Nombre,
                    .Estado = e.Estado,
                    .Fecha = e.Fecha,
                    .ConDetalle = e.Detalle.Any()
               }).ToList()
    End Function

    Public Sub Eliminar(envioID As Integer)
        UnitOfWork(
            Sub()
                Dim repo As New EnvioRepositorio()
                repo.Delete(envioID)
            End Sub)
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
        Return envio.Estado
    End Function

    Public Sub ActualizarEstado(envioID As Integer, nuevoEstado As String)
        UnitOfWork(
            Sub()
                Dim envio As Envio = New EnvioRepositorio().GetById(envioID)
                envio.ActualizarEstado(nuevoEstado)
            End Sub)
    End Sub

    Public Function TraerParaEdicion(envioID As Integer) As EnvioEdicionVistaDTO
        Dim envio As Envio = New EnvioRepositorio().GetById(envioID)
        Return New EnvioEdicionVistaDTO With {
            .ID = envio.ID,
            .ClienteID = envio.Cliente.ID,
            .DireccionDestino = envio.DireccionDestino,
            .ProvinciaID = envio.Provincia.ID,
            .ProveedorPaqueteria = envio.ProveedorPaqueteria,
            .EstadoEnvio = envio.Estado,
            .FechaEnvio = envio.Fecha,
            .CodigoSeguimiento = envio.CodigoSeguimiento,
            .Detalle = (From item In envio.Detalle
                        Select New ItemEnvioEdicionDTO With {
                           .ID = item.ID,
                           .DescripcionBulto = item.DescripcionBulto,
                           .Dimensiones = item.Dimensiones,
                           .Peso = item.Peso
                        }).ToList()
        }
    End Function

    Public Sub GuardarEnvio(envioDTO As EnvioEdicionDTO)
        UnitOfWork(
            Sub()
                Dim repo As New EnvioRepositorio()

                Dim envio As Envio = Nothing

                If envioDTO.ID.HasValue Then
                    envio = repo.GetById(envioDTO.ID)
                Else
                    envio = New Envio()
                End If

                envio.Cliente = New ClienteRepositorio().LoadById(envioDTO.ClienteID)
                envio.DireccionDestino = envioDTO.DireccionDestino
                envio.Provincia = New ProvinciaRepositorio().LoadById(envioDTO.ProvinciaID)
                envio.Fecha = envioDTO.FechaEnvio
                envio.ProveedorPaqueteria = envioDTO.ProveedorPaqueteria

                For Each item As ItemEnvio In envio.Detalle.Where(Function(ie) Not envioDTO.Detalle.Where(Function(ieDTO) ieDTO.ID = ie.ID).Any()).ToList()
                    envio.QuitarItem(item)
                Next

                For Each itemDTO In envioDTO.Detalle

                    If itemDTO.ID.HasValue Then
                        Dim itemEnvio As ItemEnvio = envio.Detalle.Where(Function(i) i.ID = itemDTO.ID).Single()
                        itemEnvio.DescripcionBulto = itemDTO.DescripcionBulto
                        itemEnvio.Dimensiones = itemDTO.Dimensiones
                        itemEnvio.Peso = itemDTO.Peso
                    Else
                        envio.AgregarItem(descripcionBulto:=itemDTO.DescripcionBulto, dimensiones:=itemDTO.Dimensiones, peso:=itemDTO.Peso)
                    End If
                Next

                Call New EnvioValidator().ValidateAndThrow(envio)

                repo.SaveOrUpdate(envio)
            End Sub)
    End Sub

End Class

Public Class EnvioEdicionDTO

    Public Property ID As Nullable(Of Integer)

    Public Property ClienteID As Integer

    Public Property DireccionDestino As String

    Public Property ProvinciaID As Integer

    Public Property ProveedorPaqueteria As String

    Public Property FechaEnvio As Date

    Public Property Detalle As IList(Of ItemEnvioEdicionDTO)
End Class

Public Class EnvioEdicionVistaDTO
    Inherits EnvioEdicionDTO

    Public Property EstadoEnvio As String

    Public Property CodigoSeguimiento As String
End Class

<Serializable>
Public Class ItemEnvioEdicionDTO
    Public Property ID As Nullable(Of Integer)

    Public Property DescripcionBulto As String

    Public Property Peso As Decimal

    Public Property Dimensiones As String
End Class

Public Class ItemDetalleEnvioDTO

    Public Property DescripcionBulto As String

    Public Property Peso As Decimal

    Public Property Dimensiones As String
End Class
