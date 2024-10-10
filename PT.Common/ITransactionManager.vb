Public Interface ITransactionManager
    Inherits IDisposable

    Sub BeginTran()
    Sub Commit()
    Sub Rollback()
    ReadOnly Property PendingTransaction As Boolean
End Interface
