Imports PT.DataAccess
Imports PT.DTOs

Public Class ProvinciaService
    Inherits ServicioBase

    Public Function TraerTodos() As List(Of IdDescripcionDTO)
        Return (From c In New ProvinciaRepositorio().GetAll()
                Select New IdDescripcionDTO(c.ID, c.Nombre)).ToList()
    End Function
End Class
