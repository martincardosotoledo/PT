Imports FluentValidation

Public Class Envio
    Inherits EntidadBase

    Public Sub New()
        Me.Estado = EstadoEnvioEnum.PENDIENTE
        _detalle = New List(Of ItemEnvio)
    End Sub

    Public Overridable Property Cliente As Cliente

    Public Overridable Property DireccionDestino As String

    Public Overridable Property Provincia As Provincia

    Public Overridable Property ProveedorPaqueteria As String

    Private _estadoEnvio As String

    Public Overridable Property Estado As String
        Get
            Return _estadoEnvio
        End Get
        Protected Set(value As String)
            _estadoEnvio = value
        End Set
    End Property


    Public Overridable Property Fecha As Date

    Public Overridable Property CodigoSeguimiento As String

    Private _detalle As IList(Of ItemEnvio)

    Public Overridable ReadOnly Property Detalle As IEnumerable(Of ItemEnvio)
        Get
            Return _detalle.AsEnumerable()
        End Get
    End Property


    Public Overridable Sub ActualizarEstado(nuevoEstado As String)
        Me.Estado = nuevoEstado

        If nuevoEstado = EstadoEnvioEnum.EN_TRANSITO Then
            Me.CodigoSeguimiento = Guid.NewGuid().ToString()
            Call New CodigoSeguimientoEnvioValidator().ValidateAndThrow(Me)
        ElseIf nuevoEstado = EstadoEnvioEnum.PENDIENTE Then
            Me.CodigoSeguimiento = Nothing
            Call New CodigoSeguimientoEnvioValidator().ValidateAndThrow(Me)
        End If
    End Sub

End Class


Public Class EnvioValidator
    Inherits AbstractValidator(Of Envio)

    Public Sub New()
        RuleFor(Function(x) x.Cliente).NotNull()
        RuleFor(Function(x) x.Provincia).NotNull()
        RuleFor(Function(x) x.ProveedorPaqueteria).NotEmpty().WithMessage("Debe especificarse el proveedor de paquetería").MaximumLength(50)
        RuleFor(Function(x) x.DireccionDestino).NotEmpty().MaximumLength(200)
        RuleFor(Function(x) x.Estado).NotEmpty()
        RuleFor(Function(x) x.Fecha).NotNull().LessThan(Date.Today.AddDays(1)).WithMessage("La fecha de envío no puede ser una fecha futura")
        Include(New CodigoSeguimientoEnvioValidator())
    End Sub
End Class

Public Class CodigoSeguimientoEnvioValidator
    Inherits AbstractValidator(Of Envio)

    Public Sub New()
        RuleFor(Function(x) x.CodigoSeguimiento).MaximumLength(50)
    End Sub
End Class
