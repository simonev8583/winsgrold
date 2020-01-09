<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialFWT.aspx.cs" Inherits="SistemaGestionRedes.HistorialFWT" %>
<%@ Register assembly="RJS.Web.WebControl.PopCalendar.Net.2010" namespace="RJS.Web.WebControl" tagprefix="rjs" %>
<%@ Register assembly="ExportToExcel" namespace="KrishLabs.Web.Controls" tagprefix="RK" %>
<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title></title>

    <script language="javascript" type="text/javascript">

        function abrirConfigColumnas() {
            window.open('ConfiguracionColumnas.aspx?IdReporte=60', '_blank', 'width=800,height=500');
            return false;
        }


        </script>

</head>

<body>
    <form id="form1" runat="server">
    <div>
     <div>
 
         <asp:Label ID="Label10" runat="server" Text="<%$ Resources:TextTittleReporte %>" 
             CssClass="NombreReporte"></asp:Label>
 
        <asp:EntityDataSource ID="EnDSFallasHistFWT" runat="server" 
            ConnectionString="name=SistemaGestionRemotoContainer" 
            DefaultContainerName="SistemaGestionRemotoContainer" 
            EntitySetName="AlarmasFWT" 
            Where="it.[ClearAlarma] is not null" Include="FWT,MtAlarma,MtAlarmas_Lenguaje" 
            onselecting="EnDSFallasHistFWT_Selecting" EnableFlattening="False" 
            OrderBy="it.Fecha DESC" 
            >
        </asp:EntityDataSource>
        <br />
        <center>
 
                
                    <asp:Label ID="Label1" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="Small" Text="<%$ Resources:TextosGlobales,TextFechaInicial %>"></asp:Label>
            <asp:TextBox ID="txtFechaInicial" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                &nbsp;<rjs:PopCalendar ID="PopCalFi" runat="server" Control="txtFechaInicial" 
                        Format="yyyy mm dd" From-Date="2011-01-01" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFiFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFiToMessage %>" />
               <br />
               <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer1" 
                        runat="server" Calendar="PopCalFi" CenterText="True" />
               <br />
               <br /> 
       <asp:Label ID="Label2" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="Small" Text="<%$ Resources:TextosGlobales,TextFechaFinal %>"></asp:Label>
                 <asp:TextBox ID="txtFechaFinal" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                &nbsp;<rjs:PopCalendar ID="PopCalFf" runat="server" Control="txtFechaFinal" 
                        Format="yyyy mm dd" From-Control="txtFechaInicial" From-Date="" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFfFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFfToMessage %>" />
                
                <br />
                <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer2" 
                        runat="server" Calendar="PopCalFf" CenterText="True" />
                   
                
            
        
      

        </center>
        
        <br />

        <center>
            <asp:Label ID="Label9" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                Text="<%$ Resources:TextosGlobales,TextoFalla %>"></asp:Label>:
            &nbsp;<asp:DropDownList ID="DDListFallas" runat="server" AppendDataBoundItems="True"
                DataSourceID="SqDSFallas" DataTextField="Nombre" DataValueField="Id" Font-Names="Microsoft Sans Serif"
                Font-Size="12px">
                <asp:ListItem Selected="True" Value="0" Text="<%$ Resources:TextTodosEventos %>"></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
        <asp:Button ID="Button1" runat="server" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" onclick="Button1_Click" 
                CssClass="TextBoton" />
        &nbsp;<asp:Button ID="btnIrConfigColumnas" runat="server" CssClass="TextBoton" 
                                    Text="<%$ Resources:TextosGlobales,TextBotonColoumnas %>" UseSubmitBehavior="False" 
                                    OnClientClick="return abrirConfigColumnas();" Width="85px" />
        </center>
&nbsp;&nbsp;
        <asp:SqlDataSource ID="SqDSFallas" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select MtAlarmas_Lenguaje.Id, MtAlarmas_Lenguaje.Nombre 
                from MtAlarmas, MtAlarmas_Lenguaje, MtLenguajes
                WHERE MtAlarmas.Id = MtAlarmas_Lenguaje.Id
                and CHARINDEX('Clear', MtAlarmas.Nombre, 1) = 0 AND TipoEquipo = 'B'
                and MtAlarmas_Lenguaje.Lang = MtLenguajes.Id
                and MtLenguajes.Cod = @IdLang" >
            <SelectParameters>
                 <asp:Parameter Name="IdLang" />
             </SelectParameters>
        </asp:SqlDataSource>

        <br />
        <br />
        <center>
        <asp:GridView ID="GVFWTData" runat="server" CellPadding="4" 
            Font-Names="Microsoft Sans Serif" Font-Size="11px" ForeColor="#333333" 
            GridLines="None" AllowPaging="True" 
                DataSourceID="SqlDSResultados" AutoGenerateColumns="False" 
                AllowSorting="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundFieldCel DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" Name="FWT" />

                <asp:BoundFieldCel DataField="Codigo" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo" Visible="false" Name="Código FWT" />

                <asp:BoundFieldCel DataField="Subestacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="Subestacion" Visible="false" Name="SubEstación" />

                <asp:BoundFieldCel DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" Visible="false" Name="Circuito" />
                
                <asp:BoundFieldCel DataField="Tramo" HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>" SortExpression="Tramo" Visible="false" Name="Tramo" />

                <asp:BoundFieldCel DataField="Nodo" HeaderText="<%$ Resources:TextosGlobales,TextoNodo %>" SortExpression="Nodo" Visible="false" Name="Nodo" />

                <asp:BoundFieldCel DataField="CalleCarrera" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" SortExpression="CalleCarrera" Visible="false" Name="Calle-Cra" />

                <asp:BoundFieldCel DataField="Numero" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" SortExpression="Numero" Visible="false" Name="Número" />

                <asp:BoundFieldCel DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" Visible="false" Name="Ciudad" />

                <asp:BoundFieldCel DataField="VersionPrograma" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="VersionPrograma" Visible="false" Name="Version Programa" />

                <asp:BoundFieldCel DataField="ASDU" HeaderText="<%$ Resources:TextosGlobales,TextoASDU %>" SortExpression="ASDU" Visible="false" Name="ASDU" />

                <asp:BoundFieldCel DataField="Nombre" HeaderText="<%$ Resources:TextosGlobales,TextoFalla %>" SortExpression="Nombre" Name="Falla" />

                <asp:BoundFieldCel DataField="Fecha" HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha" Name="Fecha Inicio" />

                <asp:BoundFieldCel DataField="ClearAlarma" HeaderText="<%$ Resources:TextosGlobales,TextoFechaClear %>" SortExpression="ClearAlarma" Name="Fecha Clear" />

                <asp:BoundFieldCel DataField="DuracionTime" HeaderText="<%$ Resources:TextDuracion %>" SortExpression="DuracionTime" Name="Duración" />

            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#0b304f" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
            <br />
            <asp:Label ID="lblMsgNoResultados" runat="server" Font-Size="Large" 
                Text="<%$ Resources:TextosGlobales,TextMsgRepNoData %>" Visible="False"></asp:Label>
            <br />
            <RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" 
                Charset="utf-8" ContentEncoding="windows-1250" EnableHyperLinks="True" 
                ExportFileName="HistorialFallasFWT.xls" GridViewID="GVFWTData" 
                IncludeTimeStamp="True" PageSize="All" Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" CssClass="TextBoton" />
        </center>
    </div>
    <p>
        &nbsp;</p>
    <asp:QueryExtender ID="qExFechas" runat="server" 
        TargetControlID="EnDSFallasHistFWT">
        
        <asp:MethodExpression MethodName="FiltrarPorFecha">
        </asp:MethodExpression>
    </asp:QueryExtender>

    <asp:QueryExtender ID="qExFalla" runat="server" 
        TargetControlID="EnDSFallasHistFWT">
        <asp:MethodExpression MethodName="FiltrarPorFalla">
        </asp:MethodExpression>
    </asp:QueryExtender>
        <asp:SqlDataSource ID="SqlDSResultados" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>" SelectCommand="select 
                FWTs.Serial,
                FWTs.Codigo,
                FWTs.ParamFWT_DireccionElectrica_SubEstacion as [Subestacion],
                FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
                FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
                FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
                FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [CalleCarrera],
                FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
                FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
                FWTs.VersionPrograma,
                FWTs.ASDU,
                MtAlarmas_Lenguaje.Nombre,
                AlarmasFWT.Fecha,
                AlarmasFWT.ClearAlarma,
                AlarmasFWT.DuracionTime
                FROM FWTs inner join AlarmasFWT on FWTs.Id = AlarmasFWT.FWTId
                join MtAlarmas on AlarmasFWT.Id = MtAlarmas.Id
                join MtAlarmas_Lenguaje on MtAlarmas.Id = MtAlarmas_Lenguaje.Id
                join MtLenguajes on MtAlarmas_Lenguaje.Lang = MtLenguajes.Id
                WHERE 
                (AlarmasFWT.Fecha between @Finicial and @Ffinal) AND
                ( (@IdFalla is null) or (AlarmasFWT.Id = @IdFalla)) AND
                (MtLenguajes.Cod = @IdLang)" CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:Parameter Name="Finicial" />
                    <asp:Parameter Name="Ffinal" />
                    <asp:Parameter Name="IdFalla" />
                    <asp:Parameter Name="IdLang" />
                </SelectParameters>
</asp:SqlDataSource>
    <br />
    </div>
    </form>
</body>
</html>
