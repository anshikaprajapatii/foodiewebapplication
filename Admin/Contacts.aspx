<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="Foodie.Admin.Contacts" %>

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
    <div class="pcoded-inner-content pt-0">
        <div class="align align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>

        <div class="col-sm-6 col-md-6 col-lg-12 mobile-inputs">
            <h4 class="sub-title">Contact Lists</h4>
            <div class="card-block table-border-style">
                <div class="table-responsive">
                    <asp:Repeater ID="rContacts" runat="server" OnItemCommand="rContacts_ItemCommand">
                        <HeaderTemplate>
                            <table class="table data-table-export table-hover nowrap">
                                <thead>
                                    <tr>
                                        <th>Sr No.</th>
                                        <th>User Name</th>
                                        <th>Email</th>
                                        <th>Subject</th>
                                        <th>Message</th>
                                        <td>Contact Date</td>
                                        <td class="datatable-nosort">Delete</td>
                                    </tr>
                                </thead>
                            <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("SrNo") %></td>
                                <td><%# Eval("Name") %></td>
                                <td><%# Eval("Email") %></td>
                                <td><%# Eval("Subject") %></td>
                                <td><%# Eval("Message") %></td>
                                <td><%# Eval("CreatedDate") %></td>
                                <td>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("ContactId") %>' CommandName="delete" CssClass="badge bg-danger" CausesValidation="false" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this contact ? ')">
                                        <i class="ti-trash"></i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
