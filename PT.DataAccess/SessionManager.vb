Imports System.IO
Imports FluentNHibernate.Cfg
Imports FluentNHibernate.Cfg.Db
Imports NHibernate
Imports NHibernate.Context
Imports NHibernate.Driver

Public Class SessionManager

    Public Shared ReadOnly Property Instance As SessionManager
        <DebuggerStepThrough>
        Get
            Return Nested.NHibernateSessionManager
        End Get
    End Property

    Private Class Nested
        Shared Sub New()
        End Sub

        Friend Shared ReadOnly NHibernateSessionManager As SessionManager = New SessionManager()
    End Class

    Public Shared _sessionFactory As ISessionFactory = Nothing

    Public Sub BuildSessionFactories(ByVal appBasePath As String)
        Dim cfgDistribucion As NHibernate.Cfg.Configuration = New NHibernate.Cfg.Configuration()
        cfgDistribucion.Configure(Path.Combine(appBasePath, "hibernateConfigFiles\pt.config"))

        _sessionFactory = Fluently.Configure(cfgDistribucion).Mappings(Sub(m)
                                                                           m.FluentMappings.AddFromAssemblyOf(Of SessionManager)()
                                                                       End Sub).BuildSessionFactory()

    End Sub

    Public Function GetCurrentSession() As ISession
        Dim sessionFactory = _sessionFactory

        If Not CurrentSessionContext.HasBind(sessionFactory) Then
            Dim session = sessionFactory.OpenSession()
            CurrentSessionContext.Bind(session)
        End If

        Return sessionFactory.GetCurrentSession()
    End Function

End Class
