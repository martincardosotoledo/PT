<%@ Page Language="VB" AutoEventWireup="false" CodeFile="envios.aspx.vb" Inherits="envios_frmEnvios" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Envíos</title>
    <script type="text/javascript">
        function btnEditar_Click(s, e) {
            editarEnvio('?id=' + s.cpId);
        }

        function nuevoEnvio() {
            editarEnvio();
        }

        function editarEnvio(urlParams) {
            var url = 'envio-edicion.aspx';
            if (urlParams !== undefined && urlParams !== null)
                url += urlParams;

            window.open(url, '_self');
        }

        // almacena el envío sobre el que se está operando actualmente
        var envioID = null;

        function btnActualizarEstado_Click(s, e) {
            envioID = s.cpId;
            popCambiarEstado.PerformCallback(s.cpId);
        }

        function endCallbackEventHandler(s, e) {
            if (popCambiarEstado.cpPopupCambioEstadoEnlazado) {
                delete popCambiarEstado.cpPopupCambioEstadoEnlazado;
                popCambiarEstado.Show();
            }
            else if (popCambiarEstado.cpEstadoActualizado) {
                delete popCambiarEstado.cpEstadoActualizado;
                popCambiarEstado.Hide();
                gvEnvios.Refresh();
            }
        }

        function btnGuardarEstado_Click(s, e) {
            popCambiarEstado.PerformCallback('ACTUALIZAR_ESTADO|' + envioID);
        }

        function popCambiarEstado_Closing(s, e) {
            ASPxClientEdit.ClearEditorsInContainer(flyCambioEstado.GetMainElement());
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxGlobalEvents ID="DevexGlobalEvents" runat="server">
            <ClientSideEvents EndCallback="endCallbackEventHandler" />
        </dx:ASPxGlobalEvents>

        <div style="display: flex; justify-content: center;">
            <dx:ASPxGridView ID="gvEnvios" runat="server" ClientInstanceName="gvEnvios" Caption="Envíos"
                KeyFieldName="EnvioID"
                EnableDetailRows="true"
                Settings-ShowTitlePanel="true"
                OnDataBinding="gvEnvios_DataBinding"
                OnRowDeleting="gvEnvios_RowDeleting">
                <SettingsBehavior EnableRowHotTrack="true" ConfirmDelete="true" />
                <SettingsPager Mode="ShowPager" PageSize="10" />
                <Settings ShowFilterRow="true" AutoFilterCondition="Contains" />
                <SettingsDetail ShowDetailRow="true" ShowDetailButtons="true" />
                <Styles>
                    <TitlePanel BorderTop-BorderStyle="None"></TitlePanel>
                </Styles>
                <SettingsCommandButton>
                    <DeleteButton>
                        <Image Url="~/imagenes/Delete.Ico" Height="15" Width="15"></Image>
                    </DeleteButton>
                </SettingsCommandButton>
                <SettingsText ConfirmDelete="Se dispone a eliminar el envío. ¿Está seguro?" />
                <Columns>
                    <dx:GridViewDataDateColumn Caption="Fecha" FieldName="Fecha" SortIndex="0" SortOrder="Descending"></dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn Caption="Cliente" FieldName="Cliente"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Provincia" FieldName="Provincia"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Estado" FieldName="Estado"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataColumn Caption="Con detalle" FieldName="ConDetalle">
                        <DataItemTemplate>
                            <%#If(CBool(DataBinder.Eval(Container.DataItem, "ConDetalle")), "&#10003;", "") %>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn>
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btnActualizarEstado" runat="server" Text="Actualizar estado" AutoPostBack="false" UseSubmitBehavior="false"
                                OnInit="btnActualizarEstado_Init">
                                <ClientSideEvents Click="btnActualizarEstado_Click" />
                            </dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn>
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btnEditar" runat="server" Text="" AutoPostBack="false" UseSubmitBehavior="false" RenderMode="Link"
                                OnInit="btnEditar_Init">
                                <ClientSideEvents Click="btnEditar_Click" />
                                <Image Url="~/imagenes/pen.ico" Height="15" Width="15"></Image>
                            </dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewCommandColumn ButtonType="Image" ShowDeleteButton="true" Width="20">
                    </dx:GridViewCommandColumn>
                </Columns>
                <Templates>
                    <TitlePanel>
                        <div style="text-align: left">
                            <dx:ASPxButton runat="server" ID="btnNuevoEnvio" Text="Nuevo envío" AutoPostBack="false" UseSubmitBehavior="false"
                                ClientSideEvents-Click="function(s, e){ nuevoEnvio(); }">
                                <Image Url="~/imagenes/add.ico" Height="15" Width="15"></Image>
                            </dx:ASPxButton>
                        </div>
                    </TitlePanel>
                    <DetailRow>
                        <dx:ASPxGridView ID="gvDetalleEnvio" runat="server" Caption="Detalle"
                            OnBeforePerformDataSelect="gvDetalleEnvio_BeforePerformDataSelect">
                            <SettingsBehavior EnableRowHotTrack="true" />
                            <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                <Settings ShowFooter="true" />
                            <Columns>
                                <dx:GridViewDataTextColumn Caption="Descripción" FieldName="DescripcionBulto" SortIndex="0" SortOrder="Ascending">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Peso" FieldName="Peso" PropertiesTextEdit-DisplayFormatString="{0:N2} kg">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Dimensiones" FieldName="Dimensiones">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <TotalSummary>
                                <dx:ASPxSummaryItem SummaryType="Sum" DisplayFormat="{0:N2} kg"  FieldName="Peso" />
                            </TotalSummary>
                        </dx:ASPxGridView>
                    </DetailRow>
                </Templates>
            </dx:ASPxGridView>
        </div>

        <dx:ASPxPopupControl ID="popCambiarEstado" runat="server" ClientInstanceName="popCambiarEstado"
            Modal="true"
            HeaderText="Cambiar estado del envío"
            PopupVerticalAlign="WindowCenter"
            PopupHorizontalAlign="WindowCenter"
            ScrollBars="Auto"
            OnWindowCallback="popCambiarEstado_WindowCallback">
            <ClientSideEvents Closing="popCambiarEstado_Closing" />
            <SettingsLoadingPanel Enabled="false" />
            <HeaderStyle HorizontalAlign="Center" />
            <ContentStyle>
                <Paddings Padding="3" />
            </ContentStyle>
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server" SupportsDisabledAttribute="True">
                    <dx:PanelContent runat="server">
                        <dx:ASPxFormLayout ID="flyCambioEstado" runat="server" ClientInstanceName="flyCambioEstado">
                            <Styles>
                                <LayoutItem Caption-Font-Bold="true">
                                    <Caption Font-Bold="True"></Caption>
                                </LayoutItem>
                            </Styles>
                            <Items>
                                <dx:LayoutItem Caption="Estado">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">
                                            <dx:ASPxComboBox ID="cmbEstado" runat="server" ClientInstanceName="cmbEstado"
                                                ValueType="System.String"
                                                IncrementalFilteringMode="Contains"
                                                OnDataBinding="cmbEstado_DataBinding">
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem Height="15"></dx:EmptyLayoutItem>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer11" runat="server">
                                            <dx:ASPxButton ID="btnGuardarEstado" runat="server" ClientInstanceName="btnGuardarEstado"
                                                Text="Guardar"
                                                AutoPostBack="false"
                                                UseSubmitBehavior="false">
                                                <Image Height="15" Width="15" Url="~/imagenes/floppy.png"></Image>
                                                <ClientSideEvents Click="btnGuardarEstado_Click" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PanelContent>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </form>
</body>
</html>
