<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARIXsAll.aspx.cs" Inherits="SistemaGestionRedes.ARIXsAll" %>

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
                    Text="<%$ Resources:TextoTittleEquiposARIX %>"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:GridView ID="gvAllArixs" runat="server" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" 
            DataSourceID="SqDSARIXs" Font-Names="Microsoft Sans Serif" Font-Size="11px" 
                    GridLines="None" HorizontalAlign="Center" 
            AllowSorting="True" PageSize="20"><AlternatingRowStyle BackColor="White" />
            
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="EditARIX.aspx?Id={0}" DataTextField="Serial" HeaderText="ARIX" />

                <asp:BoundField DataField="Id" HeaderText="<%$ Resources:TextosGlobales,TextoGenericoId %>" SortExpression="Id" />

                <asp:BoundField DataField="Codigo" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoEquipo %>" SortExpression="Codigo" />

                <asp:BoundField DataField="Identificador" HeaderText="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>" SortExpression="Identificador" />

                <asp:BoundField DataField="Fase" HeaderText="<%$ Resources:TextosGlobales,TextoFase %>" SortExpression="Fase" />

                <asp:BoundField DataField="FechaInstalacion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaInstalacion %>" SortExpression="FechaInstalacion" />
                
                <asp:BoundField DataField="FechaRegistroGestion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaRegistro %>" SortExpression="FechaRegistroGestion" />

                <asp:BoundField DataField="Serial_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial_FWT" />

                <asp:BoundField DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" />

            </Columns>

             <EditRowStyle 
                BackColor="#0b304f" />
                    <FooterStyle Font-Bold="False" ForeColor="White" />
                    <HeaderStyle 
                BackColor="#0b304f" Font-Bold="True" 
                ForeColor="White" />
                    <PagerStyle BackColor="#0b304f" ForeColor="White" 
                HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" 
                HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#C5BBAF" 
                Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle 
                BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" /><SortedDescendingCellStyle 
                BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" /></asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
  
<asp:SqlDataSource ID="SqDSARIXs" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>" 
            SelectCommand="select 
ARIXs.Id, 
ARIXs.Serial,
ARIXs.Codigo,
ARIXs.Identificador,
ARIXs.Fase, 
FWTs.Serial as [Serial_FWT],
FWTs.Codigo as [Codigo_FWT],
ARIXs.FechaInstalacion, 
ARIXs.FechaRegistroGestion
FROM ARIXs LEFT JOIN FWTs on (ARIXs.FWTId = FWTs.Id)
WHERE TipoEquipo = 4
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





