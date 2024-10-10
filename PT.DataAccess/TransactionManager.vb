Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports NHibernate
Imports NHibernate.Context
Imports NHibernate.Transaction
Imports PT.Common

Public Class TransactionManager
    Implements ITransactionManager

    Private tx As ITransaction = Nothing

    Public Sub BeginTran() Implements ITransactionManager.BeginTran
        If PendingTransaction Then Throw New InvalidOperationException("Only one transaction is allowed at a time. Create another instance of TransactionManager to nest transactions")
        tx = SessionManager.Instance.GetCurrentSession().BeginTransaction()
    End Sub

    Public Sub Commit() Implements ITransactionManager.Commit
        If Not PendingTransaction Then Throw New InvalidOperationException()
        tx.Commit()
        tx.Dispose()
        tx = Nothing
    End Sub

    Public Sub Rollback() Implements ITransactionManager.Rollback
        If Not PendingTransaction Then Throw New InvalidOperationException()

        Try
            tx.Rollback()
        Catch ex As TransactionException
            'Log.Debug(ex)
        Finally
            tx.Dispose()
            tx = Nothing
        End Try

        Dim session As ISession = SessionManager.Instance.GetCurrentSession()
        If session IsNot Nothing Then CurrentSessionContext.Unbind(session.SessionFactory)
    End Sub

    Public ReadOnly Property PendingTransaction As Boolean Implements ITransactionManager.PendingTransaction
        Get
            Return (tx IsNot Nothing AndAlso tx.IsActive AndAlso Not (tx.WasRolledBack OrElse tx.WasCommitted))
        End Get
    End Property

    Public Sub Dispose() Implements ITransactionManager.Dispose
        If tx IsNot Nothing Then
            If PendingTransaction Then Rollback()
        End If
    End Sub
End Class

