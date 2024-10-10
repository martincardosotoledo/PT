Imports PT.Dominio
Imports PT.DTOs

Public Class EnvioDb

    Private Shared envios As List(Of EnvioDTO) = {New EnvioDTO With {
        .EnvioID = 1,
        .Cliente = "Carlos",
                                   .Provincia = "BsAs",
                                   .ConDetalle = False},
                                   New EnvioDTO With {.EnvioID = 2,
                                   .Cliente = "Mario",
                                   .Provincia = "BsAs",
                                   .ConDetalle = False},
                                   New EnvioDTO With {
                                   .EnvioID = 3,
                                   .Cliente = "Juan",
                                   .Provincia = "BsAs",
                                   .ConDetalle = True}}.ToList()

    Public Function TraerParaListar() As IList(Of EnvioDTO)
        Return envios
    End Function
End Class
