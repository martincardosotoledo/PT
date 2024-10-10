Imports System.Linq.Expressions

Public Class FetchingStrategy(Of T)
    Public Property Paths As IList(Of Expression(Of Func(Of T, Object)))

    Public Sub New()
        Me.Paths = New List(Of Expression(Of Func(Of T, Object)))()
    End Sub

    Public Function AddRelationToFetch(ByVal path As Expression(Of Func(Of T, Object))) As FetchingStrategy(Of T)
        Me.Paths.Add(path)
        Return Me
    End Function
End Class
