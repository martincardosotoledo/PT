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

    Public Overridable Sub QuitarItem(item As ItemEnvio)
        If _detalle.Contains(item) Then
            _detalle.Remove(item)
        End If
    End Sub

    Public Overridable Sub AgregarItem(descripcionBulto As String, peso As Decimal, dimensiones As String)
        Dim item As New ItemEnvio() With {
            .DescripcionBulto = descripcionBulto,
            .Peso = peso,
            .Dimensiones = dimensiones
        }

        _detalle.Add(item)
    End Sub

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
        RuleFor(Function(x) x.Fecha) _
            .NotNull() _
            .GreaterThanOrEqualTo(Date.Today.AddDays(1)).WithMessage("La fecha de envío no puede ser una fecha pasada").When(Function(x) x.ID = 0) 'sólo se valida durante el alta. Sería bueno encontrar una forma más limpia de determina si se trata de un alta
        Include(New CodigoSeguimientoEnvioValidator())
        RuleFor(Function(x) x.Detalle).NotNull()
        RuleForEach(Function(x) x.Detalle).SetValidator(New ItemEnvioValidator())
    End Sub
End Class

Public Class CodigoSeguimientoEnvioValidator
    Inherits AbstractValidator(Of Envio)

    Public Sub New()
        RuleFor(Function(x) x.CodigoSeguimiento).MaximumLength(50)
    End Sub
End Class
