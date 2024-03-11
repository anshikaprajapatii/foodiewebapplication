<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Godown.aspx.cs" Inherits="Foodie.Admin.Godown" %>

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
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-4 col-lg-4">
                                            <h4 class="sub-title">Godowns</h4>
                                            <div class="form-group">
                                                <label>Godown Name</label>
                                                <div>
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Godown Name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Godown Name is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                                                    <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Godown Address</label>
                                                <div>
                                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter Godown Address" TextMode="MultiLine"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Godown address is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Pin Code</label>
                                                <div>
                                                    <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control" placeholder="Enter Godown Pin Code"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Pin Code is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPinCode"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="pb-5">
                                                <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAddOrUpdate_Click" />
                                                &nbsp;
                                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false" />
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Category Lists</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rProductInventory" runat="server" OnItemCommand="rProductInventory_ItemCommand">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Name</th>
                                                                        <th>Address</th>
                                                                        <th>Pin Code</th>
                                                                        <th>Created Date</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <tr>
                                                                <td><%# Eval("GodownName") %></td>
                                                                <td><%# Eval("GodownAddress") %></td>
                                                                <td><%# Eval("GodownPin") %> </td>
                                                                <td><%# Eval("CreatedDate") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="linkEdit" Text="Edit" runat="server" CssClass="badge bg-primary" CommandArgument='<%# Eval("GodownId") %>' CausesValidation="false" CommandName="edit">
                                                                        <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="linkDelete" Text="Delete" runat="server" CommandName="delete" CssClass="badge bg-danger" CausesValidation="false" CommandArgument='<%# Eval("GodownId") %>' OnClientClick="return confirm('Do you want to delete this product ?');">
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
