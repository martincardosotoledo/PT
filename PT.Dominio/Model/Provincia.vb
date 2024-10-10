Imports FluentValidation


Public Class Provincia
    Inherits EntidadBase

    Public Overridable Property Nombre As String

End Class


Public Class ProvinciaValidator
    Inherits AbstractValidator(Of Provincia)

    Public Sub New()
        RuleFor(Function(x) x.Nombre).NotEmpty().MaximumLength(50)
    End Sub
End Class