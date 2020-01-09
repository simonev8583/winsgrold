<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchEquipment.aspx.cs" Inherits="SistemaGestionRedes.SearchEquipment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
     
    <title></title>
</head>
<body >
    <form id="form1" runat="server">
    <div class="rightDiv">
        <%-- <div style="float:left">
           
                <asp:RadioButton ID="radButConcentrador" runat="server" GroupName="TipoEquipo" Checked="true" Text="Concentrador" />
                <br />
                <asp:RadioButton ID="radButFCI" runat="server" GroupName="TipoEquipo" Text="FCI" />
           
        </div>--%>

        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
         <div  class="centerDiv">
                              
                    <center><asp:TextBox ID="txtBoxIdEquipo" runat="server" style="margin-left: 0px" 
                            Width="245px"></asp:TextBox></center>
                    <br />
                    <center><asp:Button ID="butBuscar" runat="server" Text="<%$ Resources:TextBotonBuscar %>" onclick="butBuscar_Click" /></center>
    
       
                <br />
                <br />
         </div >
        <div class="centerDiv">
            <center>
            
            <asp:GridView ID="gridViewConsultaFWT" runat="server" CellPadding="4" 
                ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" 
                AllowPaging="True" DataKeyNames="Id" DataSourceID="sqlDataScFWT" 
                Font-Names="Microsoft Sans Serif" 
                Visible="False" ViewStateMode="Enabled" AllowSorting="True" PageSize="5" 
                    Caption="<%$ Resources:TextCaptionGVFwts %>" Font-Bold="True">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="Id" 
                        DataNavigateUrlFormatString="EditFWT.aspx?Id={0}" DataTextField="Serial" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" />
                    <asp:BoundField DataField="FechaRegistroGestion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaRegistro %>" 
                        SortExpression="FechaRegistroGestion" />
                    <asp:BoundField DataField="ParamFWT_DireccionNomenclatura_CalleCarrera" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" SortExpression="ParamFWT_DireccionNomenclatura_CalleCarrera" />
                    <asp:BoundField DataField="ParamFWT_DireccionNomenclatura_Numero" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" SortExpression="ParamFWT_DireccionNomenclatura_Numero" />
                    <asp:BoundField DataField="ParamFWT_DireccionNomenclatura_Ciudad" 
                        HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="ParamFWT_DireccionNomenclatura_Ciudad" />
                    <asp:BoundField DataField="ParamFWT_DireccionElectrica_SubEstacion" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" 
                        SortExpression="ParamFWT_DireccionElectrica_SubEstacion" />
                    <asp:BoundField DataField="ParamFWT_DireccionElectrica_Circuito" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="ParamFWT_DireccionElectrica_Circuito" />
                    <asp:BoundField DataField="ParamFWT_DireccionElectrica_Tramo" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>" SortExpression="ParamFWT_DireccionElectrica_Tramo" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#0b304f" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
            </center>
           <br />
           <br />

            <center>
            
            <asp:GridView ID="gridViewConsultaFCI" runat="server" AllowPaging="True" 
                AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                DataKeyNames="Id" DataSourceID="sqlDataScFCI" Font-Names="Microsoft Sans Serif" 
                ForeColor="#333333" GridLines="None" Visible="False" PageSize="5" 
                    Caption="<%$ Resources:TextCaptionGVFcis %>">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="Id" 
                        DataNavigateUrlFormatString="EditFCI.aspx?Id={0}" DataTextField="Serial" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" />
                    <asp:BoundField DataField="FechaRegistroGestion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaRegistro %>" 
                        SortExpression="FechaRegistroGestion" />
                    <asp:BoundField DataField="Fase" HeaderText="<%$ Resources:TextosGlobales,TextoFase %>" SortExpression="Fase" />
                    <asp:BoundField DataField="SerialFWT" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" 
                        SortExpression="SerialFWT" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#0b304f" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
           </center>
            <asp:SqlDataSource ID="sqlDataScFWT" runat="server" ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            ProviderName="System.Data.SqlClient" 
            SelectCommand = "SELECT FechaRegistroGestion, Id, ParamFWT_DireccionNomenclatura_CalleCarrera, ParamFWT_DireccionNomenclatura_Numero, 
            ParamFWT_DireccionNomenclatura_Ciudad, ParamFWT_DireccionElectrica_SubEstacion, ParamFWT_DireccionElectrica_Circuito, ParamFWT_DireccionElectrica_Tramo, 
            Serial FROM FWTs WHERE (Serial LIKE '%'+ @Serial  + '%') ORDER BY [Serial]" >
                 <SelectParameters>
                    <asp:ControlParameter ControlID="txtBoxIdEquipo" Name="Serial" PropertyName="Text" 
                        Type="string" />
                </SelectParameters>                      
            </asp:SqlDataSource>
            
            <asp:SqlDataSource ID="sqlDataScFCI" runat="server" ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                
                
                SelectCommand="SELECT FCIs.Id, FCIs.FechaRegistroGestion, FCIs.Fase, FCIs.FWTId, FCIs.Serial, FWTs.Serial AS SerialFWT FROM FCIs INNER JOIN FWTs ON FCIs.FWTId = FWTs.Id WHERE (FCIs.Serial LIKE '%' + @Serial + '%') ORDER BY FCIs.Serial" 
                onselecting="sqlDataScFCI_Selecting">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtBoxIdEquipo" Name="Serial" PropertyName="Text" 
                        Type="string" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div >


        
    </div>
    </form>
</body>
</html>
