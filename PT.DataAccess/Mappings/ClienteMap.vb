Imports FluentNHibernate.Mapping
Imports PT.Dominio

Public Class ClienteMapMap
    Inherits ClassMap(Of Cliente)

    Public Sub New()
        Table("Clientes")
        [ReadOnly]()
        Id(Function(x) x.ID).Column("ClienteID")
        Map(Function(x) x.Nombre, "Nombre")
    End Sub
End Class