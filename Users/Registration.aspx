<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Users.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Foodie.Users.Registration" %>

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

    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgUser.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>User Registration</h2>"></asp:Label>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvName" ErrorMessage="Name is required" runat="server" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtName" runat="server" placeholder="Enter Full Name" CssClass="form-control" ToolTip="Full Name"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtUsername" ForeColor="Red" ErrorMessage="Username is required"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter Username" CssClass="form-control" ToolTip="User Name"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Email is required"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter Email" CssClass="form-control" ToolTip="Email" TextMode="Email"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtMobile" ForeColor="Red" ErrorMessage="Mobile Number is required"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtMobile" runat="server" placeholder="Enter Mobile Number" CssClass="form-control" ToolTip="Mobile Number" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is required" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter Address" ToolTip="Address"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Post Code is required" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ControlToValidate="txtPostCode"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" TextMode="Number" placeholder="Enter Post Code" ToolTip="Post Code"></asp:TextBox>
                        </div>

                        <div>
                            <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="User Image" onchange="ImagePreview(this);" />
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="Enter Password" ToolTip="Password"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row pl-4">
                <div class="btn_box">
                    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" />

                    <asp:Label ID="lblAlreadyUser" runat="server" CssClass="text-black-100" Text="Already registered? "></asp:Label>
                    <a href="Login.aspx" class="badge badge-info">Login here..</a>
                </div>
            </div>

            <div class="row p-5">
                <div style="align-items: center">
                    <asp:Image ID="imgUser" runat="server" CssClass="img-thumbnail" />
                </div>
            </div>
        </div>
    </section>
</asp:Content>
