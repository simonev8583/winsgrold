<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FCIsAll.aspx.cs" Inherits="SistemaGestionRedes.FCIsAll" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
    <style type="text/css">
        .style3
        {
            height: 18px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
    <table width="100%">
        <tr>
            <td align="center">
                <asp:Label ID="Label1" runat="server" CssClass="TituloSeccion" 
                    Text="<%$ Resources:TextoTittleEquiposFCI %>"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:GridView ID="GridView1" runat="server" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" 
            DataSourceID="SqDSFCIs" Font-Names="Microsoft Sans Serif" Font-Size="11px" 
                    GridLines="None" HorizontalAlign="Center" 
            AllowSorting="True" PageSize="20"><AlternatingRowStyle BackColor="White" />
            
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="EditFCI.aspx?Id={0}" DataTextField="Serial" HeaderText="FCI" />
                
                <asp:BoundField DataField="Id" HeaderText="<%$ Resources:TextosGlobales,TextoGenericoId %>" SortExpression="Id" />

                <asp:BoundField DataField="Codigo" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoEquipo %>" SortExpression="Codigo" />

                <asp:BoundField DataField="Identificador" HeaderText="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>" SortExpression="Identificador" />

                <asp:BoundField DataField="Fase" HeaderText="<%$ Resources:TextosGlobales,TextoFase %>" SortExpression="Fase" />

                <asp:BoundField DataField="FechaInstalacion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaInstalacion %>" SortExpression="FechaInstalacion" />
                
                <asp:BoundField DataField="FechaRegistroGestion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaRegistro %>" SortExpression="FechaRegistroGestion" />
                
                <asp:BoundField DataField="TipoCircuito" HeaderText="<%$ Resources:TextosGlobales,TextoTipoCircuito %>" SortExpression="TipoCircuito" />

                <asp:BoundField DataField="Serial_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial_FWT" />

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

             <EditRowStyle 
                BackColor="#0b304f" /><FooterStyle Font-Bold="False" ForeColor="White" /><HeaderStyle 
                BackColor="#0b304f" Font-Bold="True" 
                ForeColor="White" /><PagerStyle BackColor="#0b304f" ForeColor="White" 
                HorizontalAlign="Center" /><RowStyle BackColor="#E3EAEB" 
                HorizontalAlign="Center" /><SelectedRowStyle BackColor="#C5BBAF" 
                Font-Bold="True" ForeColor="#333333" /><SortedAscendingCellStyle 
                BackColor="#F8FAFA" /><SortedAscendingHeaderStyle BackColor="#246B61" /><SortedDescendingCellStyle 
                BackColor="#D4DFE1" /><SortedDescendingHeaderStyle BackColor="#15524A" /></asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
  
<asp:SqlDataSource ID="SqDSFCIs" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>" 
            SelectCommand="select 
FCIs.Id, 
FCIs.Serial,
FCIs.Codigo,
FCIs.Identificador,
FCIs.Fase, 
FWTs.Serial as [Serial_FWT],
FWTs.Codigo as [Codigo_FWT],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
FWTs.ASDU as [Asdu],
FCIs.FechaInstalacion, 
FCIs.FechaRegistroGestion, 
case FCIs.TipoCircuito
when 1 then 'Monofásico'
when 2 then 'Bifásico'
when 3 then 'Trifásico'
end as TipoCircuito
FROM FCIs LEFT JOIN FWTs on (FCIs.FWTId = FWTs.Id)
WHERE TipoEquipo = 1
ORDER BY Id asc"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
    
    <div class= "rightDiv">
    <pre>
  
</pre>
        <pre>
   </pre>
    
    </div>

    </form>
</body>
</html>





