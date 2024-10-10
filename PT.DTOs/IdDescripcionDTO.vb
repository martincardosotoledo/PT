Public Class IdDescripcionDTO

    Sub New(ByVal id As String, ByVal descripcion As String)
        Me.ID = id
        Me.Descripcion = descripcion
    End Sub


    Public Property ID As Integer
    Public Property Descripcion As String
End Class
