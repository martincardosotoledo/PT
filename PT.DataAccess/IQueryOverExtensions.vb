Imports System.Runtime.CompilerServices
Imports NHibernate
Imports PT.Dominio

Module IQueryOverExtensions
    <Extension()>
    Function FetchingStrategy(Of T)(ByVal query As IQueryOver(Of T, T), ByVal fs As FetchingStrategy(Of T)) As IQueryOver(Of T, T)
        If fs Is Nothing Then Return query

        For Each path In fs.Paths
            query.Fetch(path).Eager.ToString()
        Next

        Return query
    End Function

End Module
