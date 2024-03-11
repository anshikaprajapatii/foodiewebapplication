<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Users.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Foodie.Users.Contact" %>

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

    <!-- book section -->
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-start">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Send Your Query</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div action="#">
                            <div>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
                            </div>
                            <div>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Your Email" TextMode="Email"></asp:TextBox>
                            </div>
                            <div>
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ErrorMessage="Subject is required" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ControlToValidate="txtSubject"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Enter Your Subject"></asp:TextBox>
                            </div>
                            <div>
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ErrorMessage="Message is required" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ControlToValidate="txtMessage"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Enter Your Message"></asp:TextBox>
                            </div>
                            <div class="btn_box">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-warning rounded-pill pl-5 pr-5 text-white" OnClick="btnSubmit_Click" />
                                 &nbsp;&nbsp;
                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-warning pl-5 pr-5 rounded-pill text-white" OnClick="btnClear_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="col-md-6">
                    <div class="map_container ">
                        <div id="googleMap"></div>
                    </div>
                </div>--%>
            </div>
        </div>
    </section>
    <!-- end book section -->
</asp:Content>
