﻿<%@ Page Title="Signup" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="_192303M_IT2163_06_AppSec_Assignment.Registration" ValidateRequest = "true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://www.google.com/recaptcha/api.js?render="></script>

    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_password.ClientID%>').value;

            if (str.length < 12) {
                document.getElementById('<%=lbl_pwerror.ClientID%>').innerHTML = "Password Length must be at least 12 characters long.";
                document.getElementById('<%=lbl_pwerror.ClientID%>').style.color = "Red";
                return ("too_short");
            }

            else if (str.search(/[0-9]/) == -1) {
                document.getElementById('<%=lbl_pwerror.ClientID%>').innerHTML = "Password requires at least 1 number.";
                document.getElementById('<%=lbl_pwerror.ClientID%>').style.color = "Red";
                return ("no_number");
            }

            else if (str.search(/[a-z]/) == -1) {
                document.getElementById('<%=lbl_pwerror.ClientID%>').innerHTML = "Password requires at least 1 lowercase letter.";
                document.getElementById('<%=lbl_pwerror.ClientID%>').style.color = "Red";
                return ("no_lower");
            }

            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById('<%=lbl_pwerror.ClientID%>').innerHTML = "Password requires at least 1 uppercase letter.";
                document.getElementById('<%=lbl_pwerror.ClientID%>').style.color = "Red";
                return ("no_upper");
            }

            else if (str.search(/[^A-Za-z0-9]/) == -1) {
                document.getElementById('<%=lbl_pwerror.ClientID%>').innerHTML = "Password requires at least 1 special character.";
                document.getElementById('<%=lbl_pwerror.ClientID%>').style.color = "Red";
                return ("no_special");
            }

            document.getElementById('<%=lbl_pwerror.ClientID%>').innerHTML = "Your password is Excellent!";
            document.getElementById('<%=lbl_pwerror.ClientID%>').style.color = "Blue";

        }
    </script>

    <div class="text-center">
        <table class="center" style="width: 80%; height: 613px;">
            <span style="text-decoration: underline; font-size: x-large"><strong>
            <br />
            Registration</strong></span><b style="font-weight: normal"><br style="font-size: x-large" />

            <tr>
                <td style="padding-bottom: 2.5%; width:50%;">

                    <asp:Label ID="lbl_firstname" runat="server" Text="First Name" style="font-size: large;"></asp:Label>
                    <br />

                    <asp:TextBox ID="tb_firstname" CssClass="userInput" runat="server"></asp:TextBox>
                    <b style="font-weight: normal">
                    <br />
            <asp:RequiredFieldValidator ID="lbl_fnerror" runat="server" ControlToValidate="tb_firstname" ErrorMessage="Please enter a first name" ForeColor="Red"></asp:RequiredFieldValidator>
    </b>

                </td>

                <td style="padding-bottom: 2.5%; width:50%;">
                    <asp:Label ID="lbl_lastname" runat="server" Text="Last Name" style="font-size: large;"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_lastname" CssClass="userInput" runat="server"></asp:TextBox>
                    <b style="font-weight: normal">
                    <br />
            <asp:RequiredFieldValidator ID="lbl_lnerror" runat="server" ControlToValidate="tb_lastname" ErrorMessage="Please enter a last name" ForeColor="Red"></asp:RequiredFieldValidator>
    </b>

                </td>
             </tr>

            <tr>
                <td colspan="2">
                    <asp:Label ID="lbl_email" runat="server" Text="Email Address" style="font-size: large;"></asp:Label>
                    <br />
                    <br />
                    <asp:TextBox ID="tb_email" CssClass="userInput" runat="server" TextMode="Email"></asp:TextBox>
                    <br />
                    <b style="font-weight: normal">
            <asp:Label ID="lbl_emailexists" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    <br />
            <asp:RequiredFieldValidator ID="lbl_emailerror" runat="server" ControlToValidate="tb_email" ErrorMessage="Please enter a valid email address" ForeColor="Red"></asp:RequiredFieldValidator>
    </b>

                    <br />
                </td>
            </tr>

            <tr>
                <td style="padding-bottom: 2.5%;" width:50%;">
                    <asp:Label ID="lbl_password" runat="server" Text="Password" style="font-size: large;"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_password" CssClass="userInput" TextMode="Password" onkeyup="javascript:validate()" runat="server"></asp:TextBox>
                    <br />
                    <b style="font-weight: normal">
            <asp:Label ID="lbl_pwerror" runat="server" ForeColor="Red"></asp:Label>

    </b>

                </td>

                <td style="padding-bottom: 2.5%;" width:50%;">
                    <br />
                    <asp:Label ID="lbl_confirmpw" runat="server" Text="Confirm Password" style="font-size: large;"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_confirmpw" CssClass="userInput" TextMode="Password" runat="server"></asp:TextBox>
                    <br />
                    <b style="font-weight: normal">
            <asp:CompareValidator ID="lbl_cfmpwerror" runat="server" ControlToCompare="tb_confirmpw" ControlToValidate="tb_password" ErrorMessage="The two passwords entered do not match" ForeColor="Red"></asp:CompareValidator>
    </b>

                </td>
            </tr>


            <asp:Label ID="lbMsg" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />

                
            <tr>
                <td style="padding-bottom: 2.5%;" colspan="2">
                    <b style="font-weight: normal">
                    <a>(Minimum 12 characters, contain upper and lowercase letters, numbers, special characters [non-alphabetic/non-numeric])</a></b>
                </td>
             </tr>

            <tr>
                <td style="padding-bottom: 2.5%;" colspan="2">
                    <asp:Label ID="lbl_dob" runat="server" Text="Date of Birth" style="font-size: large;"></asp:Label>
                    <asp:TextBox ID="tb_dob" CssClass="userInput" runat="server" TextMode="Date"/>
                    <br />
                    <b style="font-weight: normal">
            <asp:RequiredFieldValidator ID="lbl_doberror" runat="server" ControlToValidate="tb_dob" ErrorMessage="Please enter date of birth" ForeColor="Red"></asp:RequiredFieldValidator>

    </b>

                </td>
            </tr>

            <tr>
                <td style="padding-bottom: 2.5%; width:50%;">
                    <asp:Label ID="lbl_cardholder" runat="server" Text="Name of Cardholder" style="font-size: large;"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_cardholdername" CssClass="userInput" runat="server"></asp:TextBox>
                    <br />

                    <b style="font-weight: normal">
            <asp:RequiredFieldValidator ID="lbl_cardholdererror" runat="server" ControlToValidate="tb_cardholdername" ErrorMessage="Please enter name of cardholder" ForeColor="Red"></asp:RequiredFieldValidator>

    </b>

                </td>

                <td style="padding-bottom: 2.5%; width:50%;">


                    <b style="font-weight: normal">
                    <asp:Label ID="lbl_cardtype" runat="server" Text="Card Type" style="font-size: large;"></asp:Label>
                    <br />

    </b>


                    <asp:RadioButtonList ID="rb_cardtype" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" Width="100%">
                        <asp:ListItem Value="1">Visa</asp:ListItem>
                        <asp:ListItem Value="2">MasterCard</asp:ListItem>
                        <asp:ListItem Value="3">AMEX</asp:ListItem>
                    </asp:RadioButtonList>


                    <b style="font-weight: normal">
            <asp:RequiredFieldValidator ID="lbl_fnerror1" runat="server" ControlToValidate="rb_cardtype" ErrorMessage="Please select a card type" ForeColor="Red"></asp:RequiredFieldValidator>

    </b>


                </td>
            </tr>

            <tr>
                <td colspan="2" style="padding-bottom: 2.5%;">
                     <asp:Label ID="lbl_cardno" runat="server" Text="Card Number" style="font-size: large;"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_cardno" CssClass="userInput" runat="server"></asp:TextBox>
                    <br />
                     <b style="font-weight: normal">
                     <asp:RegularExpressionValidator ID="lbl_cardnoerror" runat="server" ControlToValidate="tb_cardno" ErrorMessage="Please enter a valid card number" ForeColor="Red" ValidationExpression="^[0-9]{14,16}$"></asp:RegularExpressionValidator>

    </b>

                </td>
            </tr>

            <tr>
                <td style="padding-bottom: 2.5%; width:50%;">
                    <asp:Label ID="lbl_expirydate" runat="server" Text="Expiry Date (MM/YY)" style="font-size: large;"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_expirydate" CssClass="userInput" runat="server"></asp:TextBox>
                    <br />

                    <b style="font-weight: normal">
                    <asp:RegularExpressionValidator ID="lbl_expirydateerror" runat="server" ControlToValidate="tb_expirydate" ErrorMessage="Please enter a valid expiry date" ForeColor="Red" ValidationExpression="^(0[1-9]|1[0-2])\/\d{2}$"></asp:RegularExpressionValidator>

    </b>

                </td>

                <td style="padding-bottom: 2.5%; width:50%;">
                    <asp:Label ID="lbl_cvv" runat="server" Text="CVV" style="font-size: large;"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_cvv" CssClass="userInput" runat="server"></asp:TextBox>
                    <br />

                    <b style="font-weight: normal">
                    <asp:RegularExpressionValidator ID="lbl_cvverror" runat="server" ControlToValidate="tb_cvv" ErrorMessage="Please enter a valid 3-digit CVV" ForeColor="Red" ValidationExpression="^[0-9]{3}$"></asp:RegularExpressionValidator>

    </b>

                </td>
            </tr>

            </table>

        <br />
        <br />

        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />
        <asp:Button ID="btn_signup" runat="server" Text="Signup" OnClick="btn_signup_Click" style="font-size: large"/>



    </div>

    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        })
     </script>

    </b>

</asp:Content>
