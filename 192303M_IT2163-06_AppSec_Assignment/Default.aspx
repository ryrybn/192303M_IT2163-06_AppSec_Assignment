<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="_192303M_IT2163_06_AppSec_Assignment._Default" ValidateRequest = "true" %>
<%@ MasterType VirtualPath="~/Site.Master" %> 

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <strong>
    <asp:Label ID="lbl_msg" runat="server" ForeColor="Green" style="font-size: large;"></asp:Label>
    <span style="text-decoration: underline; font-size: x-large">
    </strong>
    <div class="jumbotron">
        <h1>Welcome to SITConnect!</h1>
        <p class="lead">Serving all your stationary needs since 1992!</p>
    </div>
</asp:Content>
