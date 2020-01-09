<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CircuitFault.aspx.cs" Inherits="SistemaGestionRedes.CircuitFault" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title></title>
        
    <script type="text/javascript" language="javascript">

    var chkRedRows;

    function showdata() {
        var gvTabla = document.getElementById('<%#GVFallasCtos.ClientID%>');

        for (i = 0; i < gvTabla.rows.length; i++) {
            if (gvTabla.rows[i].cells.length == 5) {
                if (gvTabla.rows[i].cells[4].innerHTML == 'S') {
                    gvTabla.rows[i].style.backgroundColor = 'Red';
                }
            }
        }

        //setTimeout('showdata()', 250);
    }

    function checkFilasRojas() {
        var chkSilencio = document.getElementById('chkSilenciador');
        var objSonido = getFlashMovieObject('AlarmaSound');

        if (chkRedRows) {
            if (chkSilencio.checked) {
                objSonido.StopPlay();
            }
            else {
                objSonido.Play();
            }
        }
        else {
            objSonido.StopPlay();
        }
    }

    function clickSilenciar() {
        var chkSilencio = document.getElementById('chkSilenciador');
        var objSonido = getFlashMovieObject('AlarmaSound');

        if (chkSilencio.checked) {
            objSonido.StopPlay();
        }
        else {
            if (chkRedRows) {
                objSonido.Play();
            }
        }
    }

    function silencioOnLoad() {
        var objSonido = getFlashMovieObject('AlarmaSound');
        objSonido.StopPlay();
    }


    // F. Permadi May 2000
    function getFlashMovieObject(movieName) {
        if (window.document[movieName]) {
            return window.document[movieName];
        }
        if (navigator.appName.indexOf("Microsoft Internet") == -1) {
            if (document.embeds && document.embeds[movieName])
                return document.embeds[movieName];
        }
        else // if (navigator.appName.indexOf("Microsoft Internet")!=-1)
        {
            return document.getElementById(movieName);
        }
    }
    
     function abrirConfigColumnas() {
         window.open('/PagesReportes/ConfiguracionColumnas.aspx?IdReporte=80', '_blank', 'width=800,height=500');
         return false;
    }


    </script>




</head>
<body onload="silencioOnLoad();">
    <form id="form1" runat="server">
   <div class="rightDiv">

   <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
   </asp:ScriptManager>
     <div   style="position:absolute;top:0;right:0;">
                <asp:Label ID="lblHora" runat="server" Text="<%$ Resources:lblHoraText %>"></asp:Label><br />
                <asp:UpdatePanel ID="upPanTimeActual" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblTimeActual" runat="server" onload="lblTimeActual_Load"></asp:Label>
                    <asp:Timer ID="tmrTimeActual" runat="server" Interval="1000" 
                        ontick="tmrTimeActual_Tick">
                    </asp:Timer>
                </ContentTemplate>
                </asp:UpdatePanel>

    </div>
   <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtenderActual" runat="server"
            TargetControlID="ContentPanelActual"
            ExpandControlID="TitlePanelActual" 
            CollapseControlID="TitlePanelActual" 
            Collapsed="False"
            TextLabelID="LabelMostrarActual" 
            ExpandedText="<%$ Resources:CollapsiblePanelExtenderActualExpand %>" 
            CollapsedText="<%$ Resources:CollapsiblePanelExtenderActualCollap %>"
            ImageControlID="ImageActual" 
            ExpandedImage="~/Images/collapse.jpg" 
            CollapsedImage="~/Images/expand.jpg"
            SuppressPostBack="true">
</asp:CollapsiblePanelExtender>
   <asp:Panel ID="TitlePanelActual" runat="server" CssClass="collapsePanelHeader"> 
           <asp:Image ID="ImageActual" runat="server" ImageUrl="~/Images/expand.jpg"/>
           &nbsp;<asp:Label ID="lblTextTitlePanelActual" runat="server" Text="<%$ Resources:lblTextTitlePanelActualText %>"></asp:Label>&nbsp;&nbsp;
           <asp:Label ID="LabelMostrarActual" runat="server" Text="<%$ Resources:LabelMostrarActualText %>"></asp:Label>
    </asp:Panel>

   <asp:Panel ID="ContentPanelActual" runat="server" >
         <asp:SqlDataSource ID="SqDSFallasAll" runat="server" 
            
             ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
             SelectCommand="select 
FCIs.Id as [FCI], 
FCIs.Serial as [Serial],
FCIs.Codigo as [Codigo],
FCIs.Identificador as [Identificador],
FCIs.Fase as [Fase],
FWTs.Serial as [Serial_FWT],
FWTs.Codigo as [Codigo_FWT],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
FWTs.VersionPrograma as [Version_Fw],
FWTs.ASDU as [Asdu],

MtAlarmas_Lenguaje.Nombre as [Falla], 
AlarmasFCI.Valor as [Valor],
AlarmasFCI.CausaApertura as [CausaApertura],
AlarmasFCI.Fecha as [Fecha],
AlarmasFCI.Id as [IdAlarma],
FCIs.TipoEquipo as [TipoEquipo]

FROM FCIs JOIN AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId) 
JOIN MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
JOIN MtAlarmas_Lenguaje on (MtAlarmas.Id = MtAlarmas_Lenguaje.Id)
JOIN MtLenguajes on (MtAlarmas_Lenguaje.Lang = MtLenguajes.Id)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)

WHERE AlarmasFCI.ClearAlarma is null and
MtAlarmas.OrigenAlarma = 'C' and MtAlarmas.ClearedBy is not null and
MtLenguajes.Cod = @IdLang
ORDER BY Fecha DESC
">
             <SelectParameters>
                 <asp:Parameter Name="IdLang" />
             </SelectParameters>
         </asp:SqlDataSource>
         <asp:SqlDataSource ID="SqDSxFalla" runat="server" 
             ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
             SelectCommand="select 
FCIs.Id as [FCI], 
FCIs.Serial as [Serial],
FCIs.Codigo as [Codigo],
FCIs.Identificador as [Identificador],
FCIs.Fase as [Fase],
FWTs.Serial as [Serial_FWT],
FWTs.Codigo as [Codigo_FWT],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
FWTs.VersionPrograma as [Version_Fw],
FWTs.ASDU as [Asdu],

MtAlarmas_Lenguaje.Nombre as [Falla], 
AlarmasFCI.Valor as [Valor],
AlarmasFCI.CausaApertura as [CausaApertura],
AlarmasFCI.Fecha as [Fecha],
AlarmasFCI.Id as [IdAlarma],
FCIs.TipoEquipo as [TipoEquipo]

FROM FCIs JOIN AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId) 
JOIN MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
JOIN MtAlarmas_Lenguaje on (MtAlarmas.Id = MtAlarmas_Lenguaje.Id)
JOIN MtLenguajes on (MtAlarmas_Lenguaje.Lang = MtLenguajes.Id)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)

WHERE AlarmasFCI.ClearAlarma is null and
MtAlarmas.OrigenAlarma = 'C' and MtAlarmas.ClearedBy is not null
and MtAlarmas.Id = @param_id_falla and
MtLenguajes.Cod = @IdLang
ORDER BY Fecha DESC" >
            <SelectParameters>
                <asp:ControlParameter ControlID="DDListFallas" Name="param_id_falla" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:Parameter Name="IdLang" />
            </SelectParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="SqDSListaFallas" runat="server" 
            
             ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
             SelectCommand="select MtAlarmas.Id, MtAlarmas_Lenguaje.Nombre 
from MtAlarmas join MtAlarmas_Lenguaje on (MtAlarmas.Id = MtAlarmas_Lenguaje.Id)
join MtLenguajes on (MtAlarmas_Lenguaje.Lang = MtLenguajes.Id)
where MtAlarmas.OrigenAlarma = 'C' and MtAlarmas.ClearedBy is not null and
MtLenguajes.Cod = @IdLang">
             <SelectParameters>
                 <asp:Parameter Name="IdLang" DefaultValue="es" />
             </SelectParameters>
        </asp:SqlDataSource>
            <center>
            <asp:Label ID="lblFiltroFalla" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                Text="<%$ Resources:lblFiltroFallaText %>"></asp:Label>
            &nbsp;<asp:DropDownList ID="DDListFallas" runat="server" AppendDataBoundItems="True"
                AutoPostBack="True" DataSourceID="SqDSListaFallas" DataTextField="Nombre" DataValueField="Id"
                Font-Names="Microsoft Sans Serif" Font-Size="Small" 
                    OnSelectedIndexChanged="DDListFallas_SelectedIndexChanged">
                <asp:ListItem Selected="True" Value="0" Text="<%$ Resources:TextTodasFallas %>" ></asp:ListItem>
            </asp:DropDownList>
                &nbsp;<asp:Button ID="btnIrConfigColumnas" runat="server" CssClass="TextBoton" 
                    OnClientClick="return abrirConfigColumnas();" Text="<%$ Resources:TextBotonColumnas %>" 
                    UseSubmitBehavior="False" Width="85px" />
            </center>
        
        <!-- Necesario para que se actualice solo esta Zona -->
         <asp:UpdatePanel runat="server" id="UpdatePanel1" UpdateMode="Conditional" 
             onload="UpdatePanel1_Load">
        <contenttemplate>
     
        
        <asp:Timer ID="tmrCircuitFault" runat="server" Interval="4000"  
                ontick="tmrCircuitFault_Tick">
        </asp:Timer>
          
        
        <asp:GridView ID="GVFallasCtos" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" 
            Caption="<%$ Resources:GVFallasCtosCaption %>" CellPadding="5" DataSourceID="SqDSFallasAll" 
            Font-Names="Microsoft Sans Serif" Font-Size="11px" ForeColor="#333333" 
            GridLines="None" HorizontalAlign="Center" 
            ondatabound="GVFallasCtos_DataBound" CellSpacing="5" 
                onrowdatabound="GVFallasCtos_RowDataBound" 
                ondatabinding="GVFallasCtos_DataBinding" 
                DataKeyNames="IdAlarma,FCI,Fecha">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateFieldCel HeaderText="<%$ Resources:GVFallasCtosCol1Header %>" Name="Serial" >
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkEquipo" runat="server">[lnkEquipo]</asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:BoundFieldCel DataField="Codigo" HeaderText="<%$ Resources:GVFallasCtosColCodigoFCIHeader %>" SortExpression="Codigo" Visible="false" Name="Código FCI"  />

                <asp:BoundFieldCel DataField="Identificador" HeaderText="<%$ Resources:GVFallasCtosColIdentificadorFCIHeader %>" SortExpression="Identificador" Visible="false" Name="Identificador" />

                <asp:BoundFieldCel DataField="Fase" HeaderText="<%$ Resources:GVFallasCtosColFaseHeader %>" SortExpression="Fase" Visible="false" Name="Fase" />

                <asp:BoundFieldCel DataField="Serial_FWT" HeaderText="<%$ Resources:GVFallasCtosColSerialFWTHeader %>" SortExpression="Serial_FWT" Visible="false" Name="Serial FWT" />

                <asp:BoundFieldCel DataField="Codigo_FWT" HeaderText="<%$ Resources:GVFallasCtosColCodigoFWTHeader %>" SortExpression="Codigo_FWT" Visible="false" Name="Código FWT" />

                <asp:BoundFieldCel DataField="SubEstacion" HeaderText="<%$ Resources:GVFallasCtosColSubestacionHeader %>" SortExpression="SubEstacion" Visible="false" Name="SubEstación" />

                <asp:BoundFieldCel DataField="Circuito" HeaderText="<%$ Resources:GVFallasCtosColCircuitoHeader %>" SortExpression="Circuito" Visible="false" Name="Circuito" />

                <asp:BoundFieldCel DataField="Tramo" HeaderText="<%$ Resources:GVFallasCtosColTramoHeader %>" SortExpression="Tramo" Visible="false" Name="Tramo" />

                <asp:BoundFieldCel DataField="Nodo" HeaderText="<%$ Resources:GVFallasCtosColNodoHeader %>" SortExpression="Nodo" Visible="false" Name="Nodo" />

                <asp:BoundFieldCel DataField="Calle_Cra" HeaderText="<%$ Resources:GVFallasCtosColCalleKraHeader %>" SortExpression="Calle_Cra" Visible="false" Name="Calle-Cra" />

                <asp:BoundFieldCel DataField="Numero" HeaderText="<%$ Resources:GVFallasCtosColNumeroAddHeader %>" SortExpression="Numero" Visible="false" Name="Número" />

                <asp:BoundFieldCel DataField="Ciudad" HeaderText="<%$ Resources:GVFallasCtosColCiudadHeader %>" SortExpression="Ciudad" Visible="false" Name="Ciudad" />

                <asp:BoundFieldCel DataField="Version_Fw" HeaderText="<%$ Resources:GVFallasCtosColVersionFwHeader %>" SortExpression="Version_Fw" Visible="false" Name="Version Programa" />

                <asp:BoundFieldCel DataField="Asdu" HeaderText="<%$ Resources:GVFallasCtosColAsduHeader %>" SortExpression="Asdu" Visible="false" Name="ASDU" />

                <asp:BoundFieldCel DataField="Falla" HeaderText="<%$ Resources:GVFallasCtosCol2Header %>" SortExpression="Falla" Name="NmFalla" />

                <asp:TemplateFieldCel HeaderText="<%$ Resources:GVFallasCtosCol3Header %>" Name="AlarmasFCI_Valor" >
                    <ItemTemplate>
                        <asp:Label ID="lblValor" runat="server" Text='<%# Bind("Valor") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:TemplateFieldCel HeaderText="<%$ Resources:GVFallasCtosCol3aHeader %>" Name="AlarmasFCI_CausaApertura" >
                    <ItemTemplate>
                        <asp:Label ID="lblCausaOpen" runat="server" Text='<%# Bind("CausaApertura") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:BoundFieldCel DataField="Fecha" HeaderText="<%$ Resources:GVFallasCtosCol4Header %>" SortExpression="Fecha" Name="FechaAlarma" />

                <asp:TemplateFieldCel HeaderText="<%$ Resources:GVFallasCtosCol5Header %>" Name="BajarManual">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkClear" runat="server" />
                    </ItemTemplate>
                </asp:TemplateFieldCel>

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
        
         <center>
        <asp:Label ID="LblMsgNoData" runat="server"  CssClass="labelTitulo" Text="<%$ Resources:LblMsgNoDataText %>" Visible="False"></asp:Label>
        </center>
        </contenttemplate>
        </asp:UpdatePanel>

        <center>
            <table align="center" style="width:100%;">
                <tr>
                    <td align="center">
                        <input type="checkbox" id="chkSilenciador" onclick="clickSilenciar();" />
                        <asp:Label ID="lblSilencioAlarm" runat="server" 
                            Text="<%$ Resources:lblSilencioAlarmText %>"></asp:Label>
                        <object ID="AlarmaSound" align="middle" 
                            classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="" height="5" 
                            width="5">
                            <param name="allowScriptAccess" value="sameDomain" />
                            <param name="allowFullScreen" value="false" />
                            <param name="movie" value="AlarmaSound.swf" />
                            <param name="quality" value="high" />
                            <param name="bgcolor" value="#ffffff" />
                            <embed src="AlarmaSound.swf" quality="high" bgcolor="#ffffff" width="5" height="5" name="AlarmaSound" align="middle" swliveconnect="true" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
                        </object>
                    </td>
                </tr>
            </table>
            &nbsp;</center>

  </asp:Panel>
  <br />
  

   <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtenderHistorico" runat="server"
            TargetControlID="ContentPanelHistorico"
            ExpandControlID="TitlePanelHistorico" 
            CollapseControlID="TitlePanelHistorico" 
            Collapsed="True"
            TextLabelID="LabelMostrarHistorico" 
            ExpandedText="<%$ Resources:CollapsiblePanelExtenderHistoricoExpand %>" 
            CollapsedText="<%$ Resources:CollapsiblePanelExtenderHistoricoCollap %>"
            ImageControlID="ImageHistorico" 
            ExpandedImage="~/Images/collapse.jpg" 
            CollapsedImage="~/Images/expand.jpg"
            SuppressPostBack="true">
</asp:CollapsiblePanelExtender>

   <asp:Panel ID="TitlePanelHistorico" runat="server" CssClass="collapsePanelHeaderBlue"> 
           <asp:Image ID="ImageHistorico" runat="server" ImageUrl="~/Images/expand.jpg"/>
           &nbsp;<asp:Label ID="lblTextTitlePanelHistorico" runat="server" Text="<%$ Resources:lblTextTitlePanelHistoricoText %>"></asp:Label>&nbsp;&nbsp;
           <asp:Label ID="LabelMostrarHistorico" runat="server" Text="<%$ Resources:LabelMostrarHistoricoText %>"></asp:Label>
    </asp:Panel>


   <asp:Panel ID="ContentPanelHistorico" runat="server" >
         <asp:SqlDataSource ID="SqlDataSourceHistorico" runat="server" 
            
             ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
             SelectCommand="select 
Top 10 
FCIs.Id as [FCI], 
FCIs.Serial as [Serial] ,
FCIs.Codigo as [Codigo],
FCIs.Identificador as [Identificador],
FCIs.Fase as [Fase],
FWTs.Serial as [Serial_FWT],
FWTs.Codigo as [Codigo_FWT],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
FWTs.VersionPrograma as [Version_Fw],
FWTs.ASDU as [Asdu],
MtAlarmas_Lenguaje.Nombre as [Falla], 
AlarmasFCI.Valor as [Valor],
AlarmasFCI.CausaApertura as [CausaApertura],
AlarmasFCI.Fecha as [Fecha],
AlarmasFCI.ClearAlarma as [ClearAlarma],
DBO.CONVERT_TO_TIMESTR(AlarmasFCI.DuracionTime) as [DuracionTime],
FCIs.TipoEquipo as [TipoEquipo]
FROM FCIs JOIN AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId) 
JOIN MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
JOIN MtAlarmas_Lenguaje on (MtAlarmas.Id = MtAlarmas_Lenguaje.Id)
JOIN MtLenguajes on (MtAlarmas_Lenguaje.Lang = MtLenguajes.Id)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)
WHERE MtLenguajes.Cod = @IdLang
ORDER BY Fecha DESC">
             <SelectParameters>
                 <asp:Parameter Name="IdLang" />
             </SelectParameters>
         </asp:SqlDataSource>
                          
       
       <!-- Necesario para que se actualice solo esta Zona -->
         <asp:UpdatePanel runat="server" id="UpdatePanel2" UpdateMode="Conditional">
        <contenttemplate>

        <asp:Timer ID="tmrHistorico" runat="server" Interval="4000" 
                ontick="tmrHistorico_Tick"  >
        </asp:Timer>
              
        <asp:GridView ID="GridViewHistorico" runat="server" AutoGenerateColumns="False" 
            Caption="<%$ Resources:GridViewHistoricoCaption %>" CellPadding="5" DataSourceID="SqlDataSourceHistorico" 
            Font-Names="Microsoft Sans Serif" Font-Size="11px" ForeColor="#333333" 
            GridLines="None" HorizontalAlign="Center" 
            ondatabound="GridViewHistorico_DataBound" CellSpacing="5" 
                onrowdatabound="GridViewHistorico_RowDataBound">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:TemplateFieldCel HeaderText="<%$ Resources:GridViewHistoricoCol1Header %>" Name="Serial">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkEquipoHist" runat="server">[lnkEquipoHist]</asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:BoundFieldCel DataField="Codigo" HeaderText="<%$ Resources:GridViewHistoricoColCodigoFCIHeader %>" SortExpression="Codigo" Visible="false" Name="Código FCI"  />

                <asp:BoundFieldCel DataField="Identificador" HeaderText="<%$ Resources:GridViewHistoricoColIdentificadorHeader %>" SortExpression="Identificador" Visible="false" Name="Identificador" />

                <asp:BoundFieldCel DataField="Fase" HeaderText="<%$ Resources:GridViewHistoricoColFaseHeader %>" SortExpression="Fase" Visible="false" Name="Fase" />

                <asp:BoundFieldCel DataField="Serial_FWT" HeaderText="<%$ Resources:GridViewHistoricoColSerialFWTHeader %>" SortExpression="Serial_FWT" Visible="false" Name="Serial FWT" />

                <asp:BoundFieldCel DataField="Codigo_FWT" HeaderText="<%$ Resources:GridViewHistoricoColCodigoFWTHeader %>" SortExpression="Codigo_FWT" Visible="false" Name="Código FWT" />

                <asp:BoundFieldCel DataField="SubEstacion" HeaderText="<%$ Resources:GridViewHistoricoColSubestacionHeader %>" SortExpression="SubEstacion" Visible="false" Name="SubEstación" />

                <asp:BoundFieldCel DataField="Circuito" HeaderText="<%$ Resources:GridViewHistoricoColCircuitoHeader %>" SortExpression="Circuito" Visible="false" Name="Circuito" />

                <asp:BoundFieldCel DataField="Tramo" HeaderText="<%$ Resources:GridViewHistoricoColTramoHeader %>" SortExpression="Tramo" Visible="false" Name="Tramo" />

                <asp:BoundFieldCel DataField="Nodo" HeaderText="<%$ Resources:GridViewHistoricoColNodoHeader %>" SortExpression="Nodo" Visible="false" Name="Nodo" />

                <asp:BoundFieldCel DataField="Calle_Cra" HeaderText="<%$ Resources:GridViewHistoricoColCalleKraHeader %>" SortExpression="Calle_Cra" Visible="false" Name="Calle-Cra" />

                <asp:BoundFieldCel DataField="Numero" HeaderText="<%$ Resources:GridViewHistoricoColNumeroHeader %>" SortExpression="Numero" Visible="false" Name="Número" />

                <asp:BoundFieldCel DataField="Ciudad" HeaderText="<%$ Resources:GridViewHistoricoColCiudadHeader %>" SortExpression="Ciudad" Visible="false" Name="Ciudad" />

                <asp:BoundFieldCel DataField="Version_Fw" HeaderText="<%$ Resources:GridViewHistoricoColVersionFwHeader %>" SortExpression="Version_Fw" Visible="false" Name="Version Programa" />

                <asp:BoundFieldCel DataField="Asdu" HeaderText="<%$ Resources:GridViewHistoricoColAsduHeader %>" SortExpression="Asdu" Visible="false" Name="ASDU" />

                <asp:BoundFieldCel DataField="Falla" HeaderText="<%$ Resources:GridViewHistoricoCol2Header %>" SortExpression="Falla" Name="NmFalla" />

                <asp:TemplateFieldCel HeaderText="<%$ Resources:GridViewHistoricoCol3Header %>" Name="AlarmasFCI_Valor" >
                    <ItemTemplate>
                        <asp:Label ID="lblValor" runat="server" Text='<%# Bind("Valor") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:TemplateFieldCel HeaderText="<%$ Resources:GridViewHistoricoCol3aHeader %>" Name="AlarmasFCI_CausaApertura" >
                    <ItemTemplate>
                        <asp:Label ID="lblCausaOpen" runat="server" Text='<%# Bind("CausaApertura") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:BoundFieldCel DataField="Fecha" HeaderText="<%$ Resources:GridViewHistoricoCol4Header %>" SortExpression="Fecha" Name="FechaAlarma" />

                <asp:BoundFieldCel DataField="ClearAlarma" HeaderText="<%$ Resources:GridViewHistoricoCol5Header %>" SortExpression="ClearAlarma" Name="FechaClear" />

                <asp:BoundFieldCel DataField="DuracionTime" HeaderText="<%$ Resources:GridViewHistoricoCol6Header %>" SortExpression="DuracionTime" Name="DuracionFalla" />

            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#0b304f" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" HorizontalAlign="Center" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <center>
        <asp:Label ID="lblNoDataHistorico" runat="server"  CssClass="labelTitulo" 
                Text="<%$ Resources:lblNoDataHistoricoText %>" Visible="False"></asp:Label>
        </center>

        </contenttemplate>
        </asp:UpdatePanel>
       

        </asp:Panel>
    </div>
    </form>
</body>
</html>
