Imports FluentValidation

Public Class ItemEnvio
    Inherits EntidadBase

    Public Overridable Property DescripcionBulto As String

    Public Overridable Property Peso As Decimal

    Public Overridable Property Dimensiones As String

End Class


Public Class ItemEnvioValidator
    Inherits AbstractValidator(Of ItemEnvio)

    Public Sub New()
        RuleFor(Function(x) x.DescripcionBulto).NotEmpty().MaximumLength(200)
        RuleFor(Function(x) x.Peso).GreaterThan(0).WithMessage("El peso debe ser mayor a 0").PrecisionScale(10, 2, True).WithMessage("El precio debe tener como máximo 2 decimales")
        RuleFor(Function(x) x.Dimensiones).MaximumLength(50)
    End Sub
End Class