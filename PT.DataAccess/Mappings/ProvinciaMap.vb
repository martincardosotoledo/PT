Imports FluentNHibernate.Mapping
Imports PT.Dominio

Public Class ProvinciaMap
    Inherits ClassMap(Of Provincia)

    Public Sub New()
        Table("Provincias")
        [ReadOnly]()
        Id(Function(x) x.ID).Column("ProvinciaID")
        Map(Function(x) x.Nombre, "Nombre")
    End Sub
End Class