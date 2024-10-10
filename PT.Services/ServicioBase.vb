Imports PT.Common

Public MustInherit Class ServicioBase

    Protected Sub UnitOfWork(ByVal action As Action)
        UnitOfWork(action, False)
    End Sub

    Protected Sub UnitOfWork(ByVal action As Action, ByVal rollbackTran As Boolean)
        Using tm = ServiceLocator.Find(Of ITransactionManager)()
            tm.BeginTran()
            action.Invoke()

            If tm.PendingTransaction Then

                If Not rollbackTran Then
                    tm.Commit()
                Else
                    tm.Rollback()
                End If
            End If
        End Using
    End Sub
End Class
