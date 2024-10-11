Imports FluentNHibernate.Mapping
Imports PT.Dominio

Public Class EnvioMap
    Inherits ClassMap(Of Envio)

    Public Sub New()
        Table("Envios")
        Id(Function(x) x.ID).Column("EnvioID")
        References(Function(x) x.Cliente, "ClienteID")
        Map(Function(x) x.DireccionDestino, "DireccionDestino")
        References(Function(x) x.Provincia, "ProvinciaID")
        Map(Function(x) x.ProveedorPaqueteria, "ProveedorPaqueteria")
        Map(Function(x) x.Estado, "EstadoEnvio")
        Map(Function(x) x.Fecha, "FechaEnvio")
        Map(Function(x) x.CodigoSeguimiento, "CodigoSeguimiento")

        HasMany(Function(x) x.Detalle).AsBag().[Not].KeyNullable().[Not].KeyUpdate().KeyColumn("EnvioID").Cascade.AllDeleteOrphan().BatchSize(200)
    End Sub
End Class