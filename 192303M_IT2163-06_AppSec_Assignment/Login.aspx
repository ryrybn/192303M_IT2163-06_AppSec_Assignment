<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_192303M_IT2163_06_AppSec_Assignment.Login" ValidateRequest = "true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://www.google.com/recaptcha/api.js?render="></script>

    <div class="text-center">
        <br />
        <br />
        <br />
        <strong>
        <asp:Label ID="lbl_msg" runat="server" ForeColor="Green" style="font-size: large;"></asp:Label>
        <span style="text-decoration: underline; font-size: x-large">
        <br />
        <br />
        </span>
    <span style="text-decoration: underline; font-size: xx-large">Login</span></strong><span style="font-size: x-large"><br />
        <br />
        <br />
    <br />

    <asp:Label ID="lbl_emailinput" runat="server" Text="Email Address"></asp:Label>
    <br />

        </span>

    <asp:TextBox ID="tb_email" runat="server" CssClass="userInput" style="font-size: x-large;" Wrap="False"></asp:TextBox>
        <span style="font-size: x-large">
        <br />
    <br />
    <br />
    <asp:Label ID="lbl_passwordinput" runat="server" Text="Password"></asp:Label>
    <br />
        </span>
    <asp:TextBox ID="tb_password" TextMode="Password" runat="server" CssClass="userInput" style="font-size: x-large" Wrap="False"></asp:TextBox>
        <span style="font-size: x-large">
    <br />
        <br />

    <asp:Label ID="lbl_error" runat="server" ForeColor="Red"></asp:Label>
        <br />
        <br />
        <a href="Registration">Create an account</a>
        <br />
    <br />
    <br />

        </span>
    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />

    <asp:Button ID="btn_login" runat="server" Text="Login" OnClick="btn_login_Click" style="font-size: x-large" />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>

     <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        })
     </script>

</asp:Content>
