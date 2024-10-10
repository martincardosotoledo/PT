Imports PT.DataAccess

Public Class InicializacionService

    Public Sub Inicializar(appBasePath As String)
        InicializarHibernate(appBasePath)
    End Sub

    Private Sub InicializarHibernate(ByVal appBasePath As String)
        SessionManager.Instance.BuildSessionFactories(appBasePath)
    End Sub

End Class
