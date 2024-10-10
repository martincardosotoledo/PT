Imports FluentNHibernate.Mapping
Imports PT.Dominio

Public Class ItemEnvioMap
    Inherits ClassMap(Of ItemEnvio)

    Public Sub New()
        Table("EnvioDetalles")
        Id(Function(x) x.ID).Column("EnvioDetalleID")
        Map(Function(x) x.DescripcionBulto, "DescripcionBulto")
        Map(Function(x) x.Peso, "Peso")
        Map(Function(x) x.Dimensiones, "Dimensiones")
    End Sub
End Class