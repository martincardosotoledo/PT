<%@ Page Language="VB" AutoEventWireup="false" CodeFile="envio-edicion.aspx.vb" Inherits="envios_envio_edicion" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Envío - edición</title>
    <script type="text/javascript">
        function btnCancelar_Click(s, e) {
            window.open('envios.aspx', '_self');
        }

        function btnGuardar_Click(s, e) {
            if (ASPxClientEdit.ValidateEditorsInContainer(flyEdicion.GetMainElement())) {
                clbComandos.PerformCallback('GUARDAR');
            }
        }

        function endCallbackEventHandler(s, e) {
            if (clbComandos.cpGuardadoOK) {
                delete clbComandos.cpGuardadoOK;
                alert('¡Guardado exitoso!')
                window.open('envios.aspx', '_self');
            }
            else if (typeof clbComandos.cpGuardadoErrores !== 'undefined') {
                lblErrores.SetText(clbComandos.cpGuardadoErrores);
                delete clbComandos.cpGuardadoErrores;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxGlobalEvents ID="DevexGlobalEvents" runat="server">
            <ClientSideEvents EndCallback="endCallbackEventHandler" />
        </dx:ASPxGlobalEvents>
        <div style="display: flex; justify-content: center;">
            <dx:ASPxFormLayout ID="flyEdicion" runat="server" ClientInstanceName="flyEdicion"
                ColCount="2"
                Border-BorderStyle="Ridge" Border-BorderWidth="1">
                <Styles>
                    <LayoutItem>
                        <Caption Font-Bold="true"></Caption>
                    </LayoutItem>
                </Styles>
                <Items>
                    <dx:LayoutItem ShowCaption="False" ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <h3 style="text-align: center">Envío - edición</h3>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Cliente" ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox ID="cmbCliente" runat="server" ClientInstanceName="cmbCliente"
                                    ValueField="ID"
                                    TextField="Descripcion"
                                    ValueType="System.Int32"
                                    Width="400"
                                    NullText="<ELEGIR>"
                                    DropDownStyle="DropDownList"
                                    IncrementalFilteringMode="Contains"
                                    EnableCallbackMode="true" OnDataBinding="cmbCliente_DataBinding">
                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic">
                                        <RequiredField IsRequired="true" ErrorText="Debe seleccionar un cliente" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Dirección" ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtDireccion" runat="server" Width="100%" MaxLength="200">
                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic">
                                        <RequiredField IsRequired="true" ErrorText="Debe ingresar una dirección" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Provincia" ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox ID="cmbProvincia" runat="server" ClientInstanceName="cmbProvincia"
                                    ValueField="ID"
                                    TextField="Descripcion"
                                    ValueType="System.Int32"
                                    Width="400"
                                    NullText="<ELEGIR>"
                                    DropDownStyle="DropDownList"
                                    IncrementalFilteringMode="Contains"
                                    EnableCallbackMode="true" OnDataBinding="cmbProvincia_DataBinding">
                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic">
                                        <RequiredField IsRequired="true" ErrorText="Debe seleccionar una provincia" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Proveedor de paquetería" ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtProveedorPaqueteria" runat="server" Width="100%" MaxLength="50">
                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic">
                                        <RequiredField IsRequired="true" ErrorText="Debe ingresar un proveedor de paqueteríaa" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha" ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxDateEdit ID="dtFecha" runat="server" Width="100">
                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic">
                                        <RequiredField IsRequired="true" ErrorText="Debe ingresar una fecha de envío" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Estado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxLabel ID="lblEstado" runat="server"></dx:ASPxLabel>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Código de seguimiento">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxLabel ID="lblCodigoSeguimiento" runat="server"></dx:ASPxLabel>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:EmptyLayoutItem Height="15" ColSpan="2"></dx:EmptyLayoutItem>
                    <dx:LayoutItem Caption="Detalle" ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxGridView ID="gvDetalleEnvio" runat="server" ClientInstanceName="gvDetalleEnvio"
                                    KeyFieldName="GridID"
                                    OnDataBinding="gvDetalleEnvio_DataBinding"
                                    OnRowInserting="gvDetalleEnvio_RowInserting"
                                    OnRowDeleting="gvDetalleEnvio_RowDeleting"
                                    OnRowUpdating="gvDetalleEnvio_RowUpdating">
                                    <SettingsBehavior EnableRowHotTrack="true" />
                                    <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                    <Settings ShowFooter="true" />
                                    <SettingsCommandButton>
                                        <UpdateButton Text="Actualizar" RenderMode="Link"></UpdateButton>
                                        <CancelButton Text="Cancelar" RenderMode="Link"></CancelButton>
                                        <DeleteButton>
                                            <Image Url="~/imagenes/Delete.Ico"
                                                Height="15"
                                                Width="15">
                                            </Image>
                                        </DeleteButton>
                                        <EditButton RenderMode="Image">
                                            <Image Url="~/imagenes/pen.ico"
                                                Height="15"
                                                Width="15">
                                            </Image>
                                        </EditButton>
                                    </SettingsCommandButton>
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowEditButton="true" ButtonRenderMode="Button">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <HeaderTemplate>
                                                <dx:ASPxButton runat="server" ID="e" Text="" AutoPostBack="false" UseSubmitBehavior="false" RenderMode="Link" Visible="<%#Not gvDetalleEnvio.IsEditing %>"
                                                    ClientSideEvents-Click="function(s, e){ gvDetalleEnvio.AddNewRow(); }">
                                                    <Image Url="~/imagenes/add.ico" Height="15" Width="15"></Image>
                                                </dx:ASPxButton>
                                            </HeaderTemplate>
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn Caption="Descripción" FieldName="DescripcionBulto" SortIndex="0" SortOrder="Ascending">
                                            <PropertiesTextEdit MaxLength="200">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="true" ErrorText="Debe ingresar una descripción" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataSpinEditColumn Caption="Peso" FieldName="Peso" PropertiesSpinEdit-DisplayFormatString="{0:N2} kg">
                                            <PropertiesSpinEdit DecimalPlaces="2" MaxLength="11" Width="100" MinValue="0.01" MaxValue="99999999.99">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="true" ErrorText="Debe ingresar un peso" />
                                                </ValidationSettings>

                                            </PropertiesSpinEdit>
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataTextColumn Caption="Dimensiones" FieldName="Dimensiones">
                                            <PropertiesTextEdit MaxLength="50">
                                                <ValidationSettings>
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewCommandColumn
                                            ButtonType="Image"
                                            ShowDeleteButton="true">
                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                    <TotalSummary>
                                        <dx:ASPxSummaryItem SummaryType="Sum" DisplayFormat="{0:N2} kg" FieldName="Peso" />
                                    </TotalSummary>
                                </dx:ASPxGridView>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxLabel ID="lblErrores" runat="server" ClientInstanceName="lblErrores" ForeColor="Red"></dx:ASPxLabel>
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
                                            CausesValidation="false">
                                            <Image Height="15" Width="15" Url="~/imagenes/cancel.ico"></Image>
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
        </div>
        <dx:ASPxCallback ID="clbComandos" runat="server" ClientInstanceName="clbComandos" OnCallback="clbComandos_Callback">
        </dx:ASPxCallback>
    </form>
</body>
</html>
