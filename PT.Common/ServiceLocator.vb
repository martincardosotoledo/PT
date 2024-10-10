Imports Castle.MicroKernel.Registration
Imports Castle.Windsor

Public Class ServiceLocator
    Private Shared _container As IWindsorContainer = New WindsorContainer()

    Private Shared ReadOnly Property Container As IWindsorContainer
        <DebuggerStepThrough>
        Get
            Return _container
        End Get
    End Property

    <DebuggerStepThrough>
    Public Shared Function Find(Of T)() As T
        Return Container.Resolve(Of T)()
    End Function

    Public Shared Function FindAll(Of T)() As T()
        Return Container.ResolveAll(Of T)()
    End Function

    Public Shared Sub Register(ParamArray registrations As IRegistration())
        Container.Register(registrations)
    End Sub
End Class
