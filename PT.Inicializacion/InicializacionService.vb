Imports Castle.MicroKernel.Registration
Imports PT.Common
Imports PT.DataAccess

Public Class InicializacionService

    Public Sub Inicializar(appBasePath As String)
        InicializarDI()
        InicializarHibernate(appBasePath)
    End Sub

    Private Sub InicializarHibernate(ByVal appBasePath As String)
        SessionManager.Instance.BuildSessionFactories(appBasePath)
    End Sub

    Private Sub InicializarDI()
        ServiceLocator.Register(Component.[For](Of ITransactionManager)().LifeStyle.Transient.ImplementedBy(Of TransactionManager)())
    End Sub

End Class
