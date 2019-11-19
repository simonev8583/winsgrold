<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SIXsAll.aspx.cs" Inherits="SistemaGestionRedes.PagesEquipment.SIXsAll" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table width="100%">
            <tr>
                <td align="center">
                    <asp:Label ID="Label1" runat="server" CssClass="TituloSeccion" 
                        Text="<%$ Resources:TextTittlePagina %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:GridView ID="gvAllSixs" runat="server" CellPadding="4" Font-Size="11px" 
                        ForeColor="#333333" GridLines="None" 
                        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdSix" 
                        DataSourceID="SqlDSAllSix" Font-Names="Microsoft Sans Serif" 
                        ondatabound="gvAllSixs_DataBound" onrowdatabound="gvAllSixs_RowDataBound" 
                        PageSize="20">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="IdSix" 
                                DataNavigateUrlFormatString="EditSIX.aspx?Id={0}" DataTextField="Serial" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" NavigateUrl="~/PagesEquipment/EditSIX.aspx" 
                                SortExpression="Serial" />

                            <asp:BoundField DataField="Codigo" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoEquipo %>" SortExpression="Codigo" />

                            <asp:BoundField DataField="Identificador" HeaderText="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>" SortExpression="Identificador" />

                            <asp:CheckBoxField DataField="GestionScada" HeaderText="<%$ Resources:TextosGlobales,TextoTituloScada %>" 
                                ReadOnly="True" SortExpression="GestionScada" />
                            
                            <asp:BoundField DataField="FechaInstalacion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaInstalacion %>" 
                                SortExpression="FechaInstalacion" />
                            
                            <asp:BoundField DataField="TieneFallaPer" HeaderText="<%$ Resources:TextColumnaTieneFallaPerm %>" 
                                ReadOnly="True" SortExpression="TieneFallaPer" Visible="False" />

                            <asp:BoundField DataField="Fase" HeaderText="<%$ Resources:TextosGlobales,TextoFase %>" SortExpression="Fase" />
                                                        
                            <asp:BoundField DataField="FWT" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="FWT" />

                            <asp:BoundField DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" />

                            <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" />

                            <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" />

                            <asp:BoundField DataField="Tramo" HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>" SortExpression="Tramo" />

                            <asp:BoundField DataField="Nodo" HeaderText="<%$ Resources:TextosGlobales,TextoNodo %>" SortExpression="Nodo" />

                            <asp:BoundField DataField="Calle_Cra" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" SortExpression="Calle_Cra" />

                            <asp:BoundField DataField="Numero" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" SortExpression="Numero" />

                            <asp:BoundField DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />

                            <asp:BoundField DataField="Asdu" HeaderText="<%$ Resources:TextosGlobales,TextoASDU %>" SortExpression="Asdu" />
                            
                            

                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblMsgNoEquipos" runat="server" CssClass="TextError" 
                        Text="<%$ Resources:TextMsgSixNoRegistrados %>" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblMsgRedRows" runat="server" CssClass="TextError" 
                        Text="<%$ Resources:TextMsgFilasRojas %>" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDSAllSix" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                        SelectCommand="select fcis.id as IdSix, 
fcis.serial as Serial, 
FCIs.Codigo as [Codigo],
FCIs.Identificador as [Identificador],
FCIs.Fase as [Fase],
FWTs.Serial as [FWT],
FWTs.Codigo as [Codigo_FWT],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
FWTs.ASDU as [Asdu],
fcis.EnScada as [GestionScada], 
fcis.FechaInstalacion as [FechaInstalacion],
(select top 1 1 from AlarmasFCI where FCIId = FCIs.Id and Id = 178 and ClearAlarma is null) as TieneFallaPer
from FCIs left join fwts on (FCIs.fwtid = fwts.id)
where fcis.TipoEquipo = 2"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
