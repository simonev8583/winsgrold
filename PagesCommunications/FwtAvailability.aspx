<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FwtAvailability.aspx.cs" Inherits="SistemaGestionRedes.PagesCommunications.FwtAvailability" %>

<%@ Register assembly="RJS.Web.WebControl.PopCalendar.Net.2010" namespace="RJS.Web.WebControl" tagprefix="rjs" %>

<%@ Register assembly="ExportToExcel" namespace="KrishLabs.Web.Controls" tagprefix="RK" %>

<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StylesSection.css" rel="stylesheet" type="text/css" />
    
    <title></title>
</head>
<body>
    <form id="form1" runat="server">


    <div id="filtros" style="height:30%">
        <div class="centerDivFilters">
            <fieldset>
                <legend>
                    <asp:Label ID="Label1" runat="server" CssClass="legend" Text="Criterios Consulta"></asp:Label>
                </legend>

                <p>
                    <asp:Label ID="Label2" runat="server" CssClass="lebField" Text="<%$ Resources:TextosGlobales,TextFechaInicial %>"></asp:Label>
                    <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="10" Width="100px" CssClass="TextInput" ></asp:TextBox>

                    &nbsp;<rjs:PopCalendar ID="PopCalFi" runat="server" Control="txtFechaInicial" 
                            Format="yyyy mm dd" From-Date="2011-01-01" 
                            From-Message="<%$ Resources:TextosGlobales,TextCalendarFiFromMessage %>" 
                            InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiInvalidDateMessage %>" 
                            RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiRequiredDateMessage %>" 
                            To-Message="<%$ Resources:TextosGlobales,TextCalendarFiToMessage %>" />
                    &nbsp;
                    <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer1" runat="server"
                        Calendar="PopCalFi" CenterText="True" />
                </p>

                <p>
                    <asp:Label ID="Label3" runat="server" CssClass="lebField" Text="<%$ Resources:TextosGlobales,TextFechaFinal %>"></asp:Label>
                    <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="10" Width="100px" CssClass="TextInput"></asp:TextBox>

                    &nbsp;<rjs:PopCalendar ID="PopCalFf" runat="server" Control="txtFechaFinal" 
                            Format="yyyy mm dd" From-Control="txtFechaInicial" From-Date="" 
                            From-Message="<%$ Resources:TextosGlobales,TextCalendarFfFromMessage %>" 
                            InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfInvalidDateMessage %>" 
                            RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfRequiredDateMessage %>" 
                            To-Message="<%$ Resources:TextosGlobales,TextCalendarFfToMessage %>" />
                    &nbsp;
                    <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer2" runat="server"
                        Calendar="PopCalFf" CenterText="True" />
                </p>

                <%--<p>
                    <asp:Label ID="Label9" runat="server" CssClass="lebField" Text="<%$ Resources:TextosGlobales,TextoSerialFWT %>"></asp:Label>:
                    <asp:DropDownList ID="txtDDLSerialFWT" runat="server" AutoPostBack="False">
                    </asp:DropDownList>
                </p>--%>

                <p>
                    <asp:Label ID="lblInfoFWT" runat="server" Text="<%$ Resources:TextLabelFiltros %>" CssClass="lebField"></asp:Label>
                    <asp:TextBox ID="txtInfoFwt" runat="server" CssClass="textbox-300" ToolTip="<%$ Resources:TextTooltipInfoFiltro %>" ></asp:TextBox>
                </p>

                <p>
                    <asp:Button ID="btnBuscar" runat="server" 
                        Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" CssClass="TextBoton" 
                        onclick="btnBuscar_Click" />
                </p>

            </fieldset>    
        </div>
    </div>
    
    <div id="resultados">
        <div class="centerDivResultados">
            <asp:GridView ID="GVResultados" runat="server" 
                AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                CssClass="GVstyle" DataKeyNames="FWT" 
                ForeColor="#333333" GridLines="None" 
                ondatabound="GVResultados_DataBound" Width="100%">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Serial" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" 
                        SortExpression="Serial">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Codigo_FWT" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" 
                        SortExpression="Codigo_FWT" Visible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SubEstacion" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" 
                        SortExpression="SubEstacion" Visible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Circuito" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" 
                        SortExpression="Circuito" Visible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Tramo" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>" 
                        SortExpression="Tramo" Visible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Nodo" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoNodo %>" SortExpression="Nodo" 
                        Visible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Calle_Cra" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" 
                        SortExpression="Calle_Cra">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Numero" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" 
                        SortExpression="Numero">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Ciudad" 
                        HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Version_Fw" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" 
                        SortExpression="Version_Fw" Visible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Asdu" 
                        HeaderText="<%$ Resources:TextosGlobales,TextoASDU %>" SortExpression="Asdu" 
                        Visible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Disponibilidad" 
                        HeaderText="<%$ Resources:TextDisponibilidad %>" ReadOnly="True" 
                        SortExpression="Disponibilidad">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
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
        </div>
    </div>
    
    <div id="grafica">
        <div class="centerDivChart">
            <asp:Chart ID="ChartFwtAvailability" runat="server" Height="394px" 
                Width="950px" >
                    <Series>
                        <asp:Series Name="Series_Ppal" ChartArea="CAreaPpal" 
                            LegendText="<%$ Resources:TextLegendChart %>" XValueType="String" 
                            YValueType="Int32" XValueMember="Serial" YValueMembers="Disponibilidad" >
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="CAreaPpal">
                            <AxisY Title="<%$ Resources:TextAxisDisponibilidad %>" Maximum="100">
                            </AxisY>
                            <AxisX Title="<%$ Resources:TextAxisEquipos %>" Interval="1" TextOrientation="Rotated90">
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
        </div>
    </div>
    
    <asp:SqlDataSource ID="SqlDSReporte" runat="server" CancelSelectOnNullParameter="False"  
                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                SelectCommand="pa_reporte_disponibilidad_fwt" 
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="fechaIni" Type="String" />
                    <asp:Parameter Name="fechaFin" Type="String" />
                    <asp:Parameter Name="infoFWT" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

    </form>
   
</body>
</html>
