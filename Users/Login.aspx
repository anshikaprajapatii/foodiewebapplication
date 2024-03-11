<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Users.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Foodie.Users.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script>
        /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 1000);
        };
       </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <h2>Login</h2>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:Image ID="loginImage" runat="server" ImageUrl="~/Images/login.png" CssClass="img-thumbnail" AlternateText="Login" />
                        </div> 
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvUsername" ControlToValidate="txtUsername" SetFocusOnError="true" ErrorMessage="Username is required" Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter Username" ToolTip="Username" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Password is required" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" placeholder="Enter Password" ToolTip="Password" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="btn_box">
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-success rounded-pill text-white pl-4 pr-4" Text="Login" OnClick="btnLogin_Click" />
                            <span class="pl-3 text-info">New User?</span>
                            <a href="Registration.aspx" class="badge badge-info">Register here..</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
