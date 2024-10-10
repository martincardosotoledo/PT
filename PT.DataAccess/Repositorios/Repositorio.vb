Imports NHibernate
Imports NHibernate.Criterion
Imports NHibernate.Transform
Imports PT.Dominio

Public MustInherit Class Repositorio(Of T As {EntidadBase})

    Private _session As ISession

    Public Sub New(ByVal session As ISession)
        _session = session
    End Sub

    Public Sub New()
    End Sub

    Public Overridable Function UnProxyObjectAs(Of T2 As Class)(ByVal obj As Object) As T2
        Return TryCast(GetSession().GetSessionImplementation().PersistenceContext.Unproxy(obj), T2)
    End Function

    Public Overridable Function UnProxyObjectAs(ByVal obj As Object) As T
        Return TryCast(GetSession().GetSessionImplementation().PersistenceContext.Unproxy(obj), T)
    End Function

    <DebuggerStepThrough>
    Protected Function GetSession() As ISession
        If _session IsNot Nothing Then
            Return _session
        Else
            Return SessionManager.Instance.GetCurrentSession()
        End If
    End Function

    Private ReadOnly _persitentType As System.Type = GetType(T)

    Public Function GetById(ByVal entityId As Integer, Optional ByVal fs As FetchingStrategy(Of T) = Nothing) As T
        Return GetSession().QueryOver(Of T)().WhereRestrictionOn(Function(t) t.ID).IsInG(Of Integer)(New Integer() {entityId}).FetchingStrategy(fs).SingleOrDefault()
    End Function

    Public Overridable Function GetAll(ByVal Optional fs As FetchingStrategy(Of T) = Nothing) As IList(Of T)
        Dim query = GetSession().QueryOver(Of T)().FetchingStrategy(fs).TransformUsing(Transformers.DistinctRootEntity)
        Return query.List()
    End Function

    Public Function LoadById(ByVal entityId As Integer) As T
        Return GetSession().Load(Of T)(entityId)
    End Function

    'Public Overridable Function GetAll(ByVal order As Order) As IList(Of T)
    '    Return GetAll(False, order)
    'End Function

    'Public Overridable Function GetAll(ByVal fs As FetchingStrategy(Of T)) As IList(Of T)
    '    Return GetAll(False, Nothing, fs)
    'End Function

    Protected Overridable Function GetAll(ByVal cacheable As Boolean, ByVal order As Order, ByVal Optional fs As FetchingStrategy(Of T) = Nothing) As IList(Of T)
        Dim query = GetSession().QueryOver(Of T)().FetchingStrategy(fs).TransformUsing(Transformers.DistinctRootEntity)
        If order IsNot Nothing Then query.UnderlyingCriteria.AddOrder(order)
        If cacheable Then query.Cacheable()
        Return query.List()
    End Function

    Public Overridable Sub SaveOrUpdate(ByVal entity As T)
        GetSession().SaveOrUpdate(entity)
    End Sub

    Public Overridable Sub Refresh(ByVal entity As T)
        GetSession().Refresh(entity)
    End Sub

    Public Overridable Sub Delete(ByVal entity As T)
        GetSession().Delete(entity)
    End Sub

    Public Overridable Sub Delete(ByVal entityId As Integer)
        Dim entity As T = TryCast(GetSession().[Get](_persitentType, entityId), T)
        Delete(entity)
    End Sub

End Class
