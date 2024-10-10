<%@ Page Language="VB" AutoEventWireup="false" CodeFile="envio-edicion.aspx.vb" Inherits="envios_envio_edicion" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxFormLayout ID="flyEdicion" runat="server" ClientInstanceName="flyEdicion"
        ColCount="2"
        Border-BorderStyle="Ridge" Border-BorderWidth="1">
        <Styles>
            <LayoutItem>
                <Caption Font-Bold="true"></Caption>
            </LayoutItem>
        </Styles>
        <Items>
            <dx:LayoutItem Caption="Cliente" ColSpan="2">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer>
                             <dx:ASPxComboBox ID="cmbCliente" runat="server" ClientInstanceName="cmbCliente"
                                        ValueField="ID"
                                        TextField="Descripcion"
                                        ValueType="System.Int32"
                                        Width="400"
                                        DropDownStyle="DropDownList"
                                        IncrementalFilteringMode="Contains"
                                        EnableCallbackMode="true"
                                        CallbackPageSize="50"
                                      >
                                        <Buttons>
                                            <dx:EditButton Text="Todos" Position="Left"></dx:EditButton>
                                        </Buttons>
                                        <ClientSideEvents ButtonClick="function(s, e) { s.SetValue(null); }" />
                                    </dx:ASPxComboBox>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:EmptyLayoutItem Height="15" ColSpan="2"></dx:EmptyLayoutItem>
            <dx:LayoutGroup ColCount="2" GroupBoxDecoration="None" ColSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Guardar" ShowCaption="False" Width="75px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server" SupportsDisabledAttribute="True">
                                <dx:ASPxButton ID="btnGuardar" runat="server" ClientInstanceName="btnGuardar"
                                    Text="Guardar"
                                    AutoPostBack="false"
                                    UseSubmitBehavior="false"
                                    CausesValidation="false">
                                    <Image Height="15" Width="15" Url="~/imagenes/floppy.png"></Image>
                                    <ClientSideEvents Click="btnGuardar_Click" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False" Caption="Cancelar" HorizontalAlign="Right">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server" SupportsDisabledAttribute="True">
                                <dx:ASPxButton ID="btnCancelar" runat="server" ClientInstanceName="btnCancelar"
                                    Text="Cancelar"
                                    AutoPostBack="false"
                                    UseSubmitBehavior="false"
                                    CssClass="floatRight"
                                    CausesValidation="false">
                                    <ClientSideEvents Click="btnCancelar_Click" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
                <ParentContainerStyle>
                    <Paddings PaddingLeft="0px" />
                </ParentContainerStyle>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <dx:ASPxCallback ID="clbComandos" runat="server" ClientInstanceName="clbComandos">
    </dx:ASPxCallback>    </form>
</body>
</html>
