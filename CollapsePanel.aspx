<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollapsePanel.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />

</head>
<body>
<form id="form1" runat="server">

<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
</asp:ToolkitScriptManager>

<asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
            TargetControlID="ContentPanel"
            ExpandControlID="TitlePanel" 
            CollapseControlID="TitlePanel" 
            Collapsed="True"
            TextLabelID="Label1" 
            ExpandedText="(Hide Details...)" 
            CollapsedText="(Show Details...)"
            ImageControlID="Image1" 
            ExpandedImage="~/images/collapse.jpg" 
            CollapsedImage="~/images/expand.jpg"
            SuppressPostBack="true">
</asp:CollapsiblePanelExtender>
   
        
     <asp:Panel ID="TitlePanel" runat="server" CssClass="collapsePanelHeader"> 
           <asp:Image ID="Image1" runat="server" ImageUrl="~/images/expand.jpg"/>
           Who am I ?&nbsp;&nbsp;
           <asp:Label ID="Label1" runat="server">(Show Details...)</asp:Label>
    </asp:Panel>
    
    <asp:Panel ID="ContentPanel" runat="server" >
        <h1>
            <br />
            Just your average MS Joe ...</h1>
        &nbsp;If you would like to contact me you can send email from my blog at either
        of the following web sites.<p>
            <a href="http://www.JoeOn.net">http://www.JoeOn.net</a></p>
        <p>
            <a href="http://blogs.msdn.com/JoeStagner">http://blogs.msdn.com/JoeStagner</a></p>
        <p>
            I'm a Program Manager on the Microsoft Web Tools and Platform.&nbsp;
        </p>
        <p>
            While my team is based in Redmond WA, I live in New England USA with my beautiful
            wife and children and work wherever the job takes me. I joined Microsoft in 2001
            after starting, building, and selling a .COM firm in New York City. I began as a
            strategic advisor to independent software venders (ISV), moved to a position as
            a Developer Technology Expert ad Technical Evangelist, and after three years I moved
            to the Web Tools and Platform Team.</p>
        <p>
            <img align="right" border="0" height="150" src="images/JoeStagUK.gif" width="150" /></p>
        <h2>
            What do I do at Microsoft ?</h2>
        <p>
            You would think this should be an easy question, but it's actually not.
        </p>
        <p>
            My job has many parts.
        </p>
        <p>
            To communicate with Microsoft's Web Development Customers, to know as much as I
            can about all web development technologies, those made by Microsoft and those made
            by everyone else, and to communicate from the world to the Web development product
            teams and from the web development product teams to the development community.
        </p>
    </asp:Panel>

    </form>
</body>
</html>
